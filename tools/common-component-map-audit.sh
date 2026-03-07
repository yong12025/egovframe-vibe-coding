#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  ./tools/common-component-map-audit.sh <PROJECT_DIR> [OUTPUT_MD]

Example:
  ./tools/common-component-map-audit.sh /path/to/project /tmp/component-map-report.md
USAGE
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

PROJECT_DIR="$1"
OUTPUT_MD="${2:-}"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "[ERROR] PROJECT_DIR not found: $PROJECT_DIR" >&2
  exit 1
fi

if ! command -v rg >/dev/null 2>&1; then
  echo "[ERROR] ripgrep(rg) is required." >&2
  exit 1
fi

TMP_REPORT="$(mktemp)"

print_line() {
  printf "%s\n" "$1" >> "$TMP_REPORT"
}

score_recommendation() {
  local count="$1"
  if [ "$count" -eq 0 ]; then
    echo "탐지 안됨(공통컴포넌트 우선 검토)"
  elif [ "$count" -lt 20 ]; then
    echo "일부 구현 존재(재사용/통합 검토)"
  else
    echo "구현 다수 존재(중복 개발 위험)"
  fi
}

count_matches() {
  local pattern="$1"
  { rg --hidden --glob '!.git' -n -i -e "$pattern" "$PROJECT_DIR" 2>/dev/null || true; } | wc -l | tr -d ' '
}

sample_matches() {
  local pattern="$1"
  { rg --hidden --glob '!.git' -n -i -e "$pattern" "$PROJECT_DIR" 2>/dev/null || true; } | head -n 5 | sed "s#^$PROJECT_DIR/##"
}

print_line "# Common Component Map Audit Report"
print_line ""
print_line "- 대상 경로: $PROJECT_DIR"
print_line "- 실행 시각: $(date '+%Y-%m-%d %H:%M:%S %z')"
print_line ""
print_line "## Summary"
print_line ""
print_line "| 기능 | 탐지 수 | 권장 조치 |"
print_line "|---|---:|---|"

COMPONENTS=$(cat <<'LIST'
로그인|login|signin|auth|security
게시판|board|bbs|post|article
사용자관리|user|member|account|role|authority
공통코드|commoncode|codegroup|code
메뉴관리|menu|navigation
로그관리|audit|log|trace
배치관리|batch|job|scheduler|chunk
LIST
)

while IFS='|' read -r name p1 p2 p3 p4 p5 p6; do
  pattern="$p1"
  [ -n "${p2:-}" ] && pattern="$pattern|$p2"
  [ -n "${p3:-}" ] && pattern="$pattern|$p3"
  [ -n "${p4:-}" ] && pattern="$pattern|$p4"
  [ -n "${p5:-}" ] && pattern="$pattern|$p5"
  [ -n "${p6:-}" ] && pattern="$pattern|$p6"

  count="$(count_matches "$pattern")"
  recommendation="$(score_recommendation "$count")"
  print_line "| $name | $count | $recommendation |"
done <<< "$COMPONENTS"

print_line ""
print_line "## Samples"

while IFS='|' read -r name p1 p2 p3 p4 p5 p6; do
  pattern="$p1"
  [ -n "${p2:-}" ] && pattern="$pattern|$p2"
  [ -n "${p3:-}" ] && pattern="$pattern|$p3"
  [ -n "${p4:-}" ] && pattern="$pattern|$p4"
  [ -n "${p5:-}" ] && pattern="$pattern|$p5"
  [ -n "${p6:-}" ] && pattern="$pattern|$p6"

  print_line ""
  print_line "### $name"
  sample="$(sample_matches "$pattern" || true)"
  if [ -z "$sample" ]; then
    print_line "- 탐지된 항목 없음"
  else
    print_line '```text'
    print_line "$sample"
    print_line '```'
  fi
done <<< "$COMPONENTS"

if [ -n "$OUTPUT_MD" ]; then
  cp "$TMP_REPORT" "$OUTPUT_MD"
  echo "[OK] report written: $OUTPUT_MD"
else
  cat "$TMP_REPORT"
fi

rm -f "$TMP_REPORT"
