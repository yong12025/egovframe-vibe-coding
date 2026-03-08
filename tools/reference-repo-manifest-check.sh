#!/usr/bin/env bash
set -euo pipefail

normalize_path() {
  local input="$1"
  if [[ "$input" =~ ^[A-Za-z]:[\\/] ]]; then
    if command -v wslpath >/dev/null 2>&1; then
      wslpath -u "$input"
      return
    fi
    if command -v cygpath >/dev/null 2>&1; then
      cygpath -u "$input"
      return
    fi
    local drive="${input:0:1}"
    local rest="${input:2}"
    rest="${rest//\\//}"
    printf '/mnt/%s%s\n' "$(printf '%s' "$drive" | tr '[:upper:]' '[:lower:]')" "$rest"
    return
  fi
  printf '%s\n' "$input"
}

resolve_rg() {
  local candidate
  candidate="$(command -v rg 2>/dev/null || true)"
  if [[ -n "$candidate" ]] && "$candidate" --version >/dev/null 2>&1; then
    printf '%s\n' "$candidate"
    return 0
  fi
  return 1
}

if [[ $# -lt 1 ]]; then
  echo "Usage: ./tools/reference-repo-manifest-check.sh <MANIFEST_YML> [OUTPUT_MD]" >&2
  exit 1
fi

MANIFEST_YML="$(normalize_path "$1")"
OUTPUT_MD="$(normalize_path "${2:-/tmp/reference-repo-manifest-report.md}")"

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

RG_BIN="$(resolve_rg || true)"

has_pattern() {
  local pattern="$1"
  local file="$2"
  if [[ -n "${RG_BIN:-}" ]]; then
    "$RG_BIN" -q "$pattern" "$file"
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
