#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: ./tools/reference-repo-manifest-check.sh <MANIFEST_YML> [OUTPUT_MD]" >&2
  exit 1
fi

MANIFEST_YML="$1"
OUTPUT_MD="${2:-/tmp/reference-repo-manifest-report.md}"

if [[ ! -f "$MANIFEST_YML" ]]; then
  echo "[ERROR] manifest not found: $MANIFEST_YML" >&2
  exit 1
fi

status="PASS"
missing=()
warnings=()

required_patterns=(
  '^version:'
  '^updated_at:'
  '^owner:'
  '^default_branch:'
  '^lane_repos:'
  'lane:[[:space:]]*v4\.3'
  'lane:[[:space:]]*v5\.0-beta'
  'repo_name:'
  'repo_url:'
  'convention_profile:'
  'scenarios:'
)

has_pattern() {
  local pattern="$1"
  local file="$2"
  if command -v rg >/dev/null 2>&1; then
    rg -q "$pattern" "$file"
  else
    grep -Eq "$pattern" "$file"
  fi
}

for p in "${required_patterns[@]}"; do
  if ! has_pattern "$p" "$MANIFEST_YML"; then
    missing+=("pattern:$p")
  fi
done

if has_pattern '<ORG_OR_USER>' "$MANIFEST_YML"; then
  warnings+=("owner/repo_url uses placeholder <ORG_OR_USER>")
fi

if [[ ${#missing[@]} -gt 0 ]]; then
  status="FAIL"
fi

mkdir -p "$(dirname "$OUTPUT_MD")"
{
  echo "# Reference Repo Manifest Check Report"
  echo
  echo "manifest: $MANIFEST_YML"
  echo "status: $status"
  echo
  echo "## Required Fields"
  if [[ ${#missing[@]} -eq 0 ]]; then
    echo "- result: PASS"
  else
    echo "- result: FAIL"
    for m in "${missing[@]}"; do
      echo "- missing: $m"
    done
  fi
  echo
  echo "## Warnings"
  if [[ ${#warnings[@]} -eq 0 ]]; then
    echo "- none"
  else
    for w in "${warnings[@]}"; do
      echo "- $w"
    done
  fi

  echo
  echo "## Next Actions"
  echo '1. 실제 <ORG_OR_USER> 값으로 owner/repo_url 치환'
  echo "2. 각 lane 저장소 공개 후 status를 planned -> active로 갱신"
  echo "3. README에 lane 저장소 URL 연결"
} > "$OUTPUT_MD"

echo "[OK] report written: $OUTPUT_MD"
if [[ "$status" == "FAIL" ]]; then
  exit 1
fi
