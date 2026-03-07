#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: ./tools/pre-upload-full-review.sh <REPO_DIR> [OUTPUT_MD]" >&2
  exit 1
fi

REPO_DIR="$1"
OUTPUT_MD="${2:-/tmp/pre-upload-review-report.md}"

if [[ ! -d "$REPO_DIR" ]]; then
  echo "[ERROR] REPO_DIR not found: $REPO_DIR" >&2
  exit 1
fi

timestamp="$(date '+%Y-%m-%d %H:%M:%S %z')"

shell_syntax="PASS"
yaml_parse="PASS"
std_readiness="PASS"
convention_review="PASS"
manifest_review="PASS"

std_report="/tmp/pre-upload-standard-readiness.md"
std_summary="/tmp/pre-upload-standard-summary.md"
conv_report="/tmp/pre-upload-convention-report.md"
manifest_report="/tmp/pre-upload-manifest-report.md"

# 1) 자동 점검
if ! bash -n "$REPO_DIR"/tools/*.sh >/dev/null 2>&1; then
  shell_syntax="FAIL"
fi

if ! ruby -ryaml -e 'Dir.glob(ARGV[0]).each { |p| YAML.load_file(p) }' "$REPO_DIR/.github/workflows/*.yml" >/dev/null 2>&1; then
  yaml_parse="FAIL"
fi

if ! "$REPO_DIR/tools/standard-readiness-check.sh" "$REPO_DIR" "$std_report" >/dev/null 2>&1; then
  std_readiness="FAIL"
fi

if ! "$REPO_DIR/tools/standard-readiness-dashboard.sh" "$std_report" "$std_summary" /tmp/pre-upload-standard-badge.json >/dev/null 2>&1; then
  std_readiness="FAIL"
fi

if ! "$REPO_DIR/tools/convention-recommend.sh" "$REPO_DIR" --lane v5.0-beta --mode auto --output "$conv_report" >/dev/null 2>&1; then
  convention_review="FAIL"
fi

if ! "$REPO_DIR/tools/reference-repo-manifest-check.sh" "$REPO_DIR/references/repos.manifest.yml" "$manifest_report" >/dev/null 2>&1; then
  manifest_review="FAIL"
fi

selected_profile="$(rg -n "selected_profile" "$conv_report" | head -n1 | sed -E 's/.*`([^`]*)`.*/\1/' || true)"
confidence_score="$(rg -n "confidence_score" "$conv_report" | head -n1 | sed -E 's/.*`([^`]*)`.*/\1/' || true)"
selected_profile="${selected_profile:-N/A}"
confidence_score="${confidence_score:-N/A}"

# 2) 상황별 점검 매핑
scenario_operator="PASS"
scenario_beginner="PASS"
scenario_repo_owner="PASS"
scenario_pr_contributor="PASS"
scenario_ci="PASS"

operator_guard_readme="NO"
operator_guard_rules="NO"
if rg -q "요청 범위 밖의 로직/동작은 변경하지 않음" "$REPO_DIR/README.md"; then
  operator_guard_readme="YES"
fi
if rg -q "요청 범위 밖|최소 변경|범위 밖" "$REPO_DIR/docs/agent-rules.md" "$REPO_DIR/AGENTS.md" "$REPO_DIR/prompts/tool-profiles/unified-agent-instruction.md"; then
  operator_guard_rules="YES"
fi
if [[ "$operator_guard_readme" != "YES" || "$operator_guard_rules" != "YES" ]]; then
  scenario_operator="WARN"
fi

if ! rg -q "10분 내 기대 산출물" "$REPO_DIR/README.md"; then
  scenario_beginner="WARN"
fi

if [[ "$std_readiness" == "FAIL" || "$manifest_review" == "FAIL" ]]; then
  scenario_repo_owner="WARN"
fi

if ! rg -q "standard-readiness-check\.sh" "$REPO_DIR/CONTRIBUTING.md" || ! rg -q "reference-repo-manifest-check\.sh" "$REPO_DIR/.github/PULL_REQUEST_TEMPLATE.md"; then
  scenario_pr_contributor="WARN"
fi

if [[ "$yaml_parse" == "FAIL" ]]; then
  scenario_ci="WARN"
fi

# 3) 라벨 판정
issues=()
has_official_deviation="NO"
has_repo_policy_gap="NO"
has_ux_improvement="NO"

# Official-Deviation: 공식 URL 안정성
unstable_official_links_count="$(rg -n "nttRead\.do\?bbsId=6&nttId=1932" "$REPO_DIR/docs" "$REPO_DIR/README.md" | wc -l | tr -d ' ' || true)"
if [[ "$unstable_official_links_count" != "0" ]]; then
  issues+=("Official-Deviation|Medium|공지 링크 일부가 안정 접속 파라미터(menuNo=66) 없이 존재")
  has_official_deviation="YES"
fi

# Repo-Policy-Gap: 운영자 보존 원칙 일관성
if [[ "$scenario_operator" == "WARN" ]]; then
  issues+=("Repo-Policy-Gap|Medium|운영자용 기존 로직 보존 원칙이 README 외 규약 문서에 충분히 명시되지 않음")
  has_repo_policy_gap="YES"
fi

# UX-Improvement: placeholder URL
if rg -q "<OWNER>/<REPO>" "$REPO_DIR/README.md"; then
  issues+=("UX-Improvement|Low|README clone URL이 placeholder 상태")
  has_ux_improvement="YES"
fi

# 4) 보고서 출력
mkdir -p "$(dirname "$OUTPUT_MD")"
{
  echo "# Pre-upload Full Review Report"
  echo
  echo "generated_at: $timestamp"
  echo "repo_dir: $REPO_DIR"
  echo "review_policy: 공식+실무확장"
  echo "release_gate: 권고만 제공(차단 없음)"
  echo "scope: 운영자/처음사용자/저장소운영자/PR기여자/CI"
  echo
  echo "## 상황별 결과"
  echo
  echo "| 상황 | 결과 | 근거 |"
  echo "| --- | --- | --- |"
  echo "| 운영자(기존 프로젝트) | $scenario_operator | operator_guard_readme=$operator_guard_readme, operator_guard_rules=$operator_guard_rules |"
  echo "| 처음 사용자(신규) | $scenario_beginner | README 10분 산출물/온보딩 경로 존재 여부 |"
  echo "| 저장소 운영자(릴리스 전) | $scenario_repo_owner | standard-readiness=$std_readiness, manifest=$manifest_review |"
  echo "| PR 기여자 | $scenario_pr_contributor | CONTRIBUTING/PR 템플릿 검증 명령 포함 여부 |"
  echo "| CI 관점 | $scenario_ci | workflow YAML parse=$yaml_parse |"
  echo
  echo "자동 점검 스냅샷"
  echo
  echo "- shell_syntax: $shell_syntax"
  echo "- yaml_parse: $yaml_parse"
  echo "- standard_readiness: $std_readiness"
  echo "- convention_recommend: $convention_review"
  echo "- reference_manifest: $manifest_review"
  echo "- selected_profile: $selected_profile"
  echo "- confidence_score: $confidence_score"
  echo
  echo "## 공식 이탈 요약"
  echo
  if [[ ${#issues[@]} -eq 0 ]]; then
    echo "- 판정 항목 없음"
  else
    for issue in "${issues[@]}"; do
      IFS='|' read -r label severity detail <<< "$issue"
      echo "- [$label][$severity] $detail"
    done
  fi
  echo
  echo "근거 URL"
  echo
  echo "- https://www.egovframe.go.kr/home/sub.do?menuNo=12"
  echo "- https://www.egovframe.go.kr/home/ntt/nttRead.do?bbsId=6&menuNo=66&nttId=1932"
  echo "- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:dev4.3:gettingstarted"
  echo "- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:com:v4.3:init_guide"
  echo
  echo "## 즉시 수정 권고"
  echo
  if [[ ${#issues[@]} -eq 0 ]]; then
    echo "- 즉시 수정 권고 없음"
  else
    idx=1
    if [[ "$has_repo_policy_gap" == "YES" ]]; then
      echo "$idx. [Medium] 운영자 보존 원칙을 README/AGENTS/docs/agent-rules/unified instruction에 동일 문구로 정렬"
      idx=$((idx+1))
    fi
    if [[ "$has_official_deviation" == "YES" ]]; then
      echo "$idx. [Medium] nttId=1932 링크를 menuNo=66 포함 안정 URL로 통일"
      idx=$((idx+1))
    fi
    if [[ "$has_ux_improvement" == "YES" ]]; then
      echo "$idx. [Low] README placeholder(<OWNER>/<REPO>)를 실제 URL 또는 <GUIDE_REPO_URL> 패턴으로 정리"
    fi
  fi
  echo
  echo "## 후속 권고"
  echo
  echo "1. PR 머지 전 본 리포트와 /tmp/standard-readiness-report.md를 첨부"
  echo "2. 공식 버전 페이지(menuNo=12) 분기별 재검증 루틴 운영"
  echo "3. 외부 샘플 저장소 공개 후 references/repos.manifest.yml의 status planned->active 갱신"
} > "$OUTPUT_MD"

echo "[OK] report written: $OUTPUT_MD"
