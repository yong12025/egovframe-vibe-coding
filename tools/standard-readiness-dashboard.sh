#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: ./tools/standard-readiness-dashboard.sh <READINESS_REPORT_MD> [OUTPUT_SUMMARY_MD] [OUTPUT_BADGE_JSON]" >&2
  exit 1
fi

READINESS_REPORT_MD="$1"
OUTPUT_SUMMARY_MD="${2:-/tmp/standard-readiness-summary.md}"
OUTPUT_BADGE_JSON="${3:-/tmp/standard-readiness-badge.json}"

if [[ ! -f "$READINESS_REPORT_MD" ]]; then
  echo "[ERROR] READINESS_REPORT_MD not found: $READINESS_REPORT_MD" >&2
  exit 1
fi

extract_first_value() {
  local pattern="$1"
  local file="$2"
  local result
  if command -v rg >/dev/null 2>&1; then
    result="$(rg -n "$pattern" "$file" | head -n1 || true)"
  else
    result="$(grep -nE "$pattern" "$file" | head -n1 || true)"
  fi
  printf '%s' "$result"
}

generated_at="$(extract_first_value '^generated_at:' "$READINESS_REPORT_MD" | sed -E 's/^.*generated_at:[[:space:]]*//')"
repo_dir="$(extract_first_value '^repo_dir:' "$READINESS_REPORT_MD" | sed -E 's/^.*repo_dir:[[:space:]]*//')"
status="$(extract_first_value '^status:' "$READINESS_REPORT_MD" | sed -E 's/^.*status:[[:space:]]*//' | tr '[:lower:]' '[:upper:]')"
missing_count="$(extract_first_value '^- missing_count:' "$READINESS_REPORT_MD" | sed -E 's/^.*- missing_count:[[:space:]]*//' || true)"
selected_profile="$(extract_first_value '^- selected_profile:' "$READINESS_REPORT_MD" | sed -E 's/^.*- selected_profile:[[:space:]]*//' || true)"
confidence_score="$(extract_first_value '^- confidence_score:' "$READINESS_REPORT_MD" | sed -E 's/^.*- confidence_score:[[:space:]]*//' || true)"

status="${status:-UNKNOWN}"
missing_count="${missing_count:-0}"
selected_profile="${selected_profile:-N/A}"
confidence_score="${confidence_score:-N/A}"
generated_at="${generated_at:-N/A}"
repo_dir="${repo_dir:-N/A}"

badge_color="red"
badge_message="$status"
if [[ "$status" == "PASS" ]]; then
  badge_color="brightgreen"
fi

mkdir -p "$(dirname "$OUTPUT_SUMMARY_MD")"
mkdir -p "$(dirname "$OUTPUT_BADGE_JSON")"

{
  echo "# Standard Readiness Dashboard"
  echo
  echo "generated_at: $generated_at"
  echo "repo_dir: $repo_dir"
  echo
  echo "| metric | value |"
  echo "| --- | --- |"
  echo "| status | $status |"
  echo "| missing_count | $missing_count |"
  echo "| selected_profile | $selected_profile |"
  echo "| confidence_score | $confidence_score |"
  echo
  if [[ "$status" == "PASS" ]]; then
    echo "- decision: release-ready (standard baseline satisfied)"
  else
    echo "- decision: not-ready (missing assets or smoke test failure)"
  fi
} > "$OUTPUT_SUMMARY_MD"

cat > "$OUTPUT_BADGE_JSON" <<JSON
{"schemaVersion":1,"label":"standard-readiness","message":"$badge_message","color":"$badge_color"}
JSON

echo "[OK] summary written: $OUTPUT_SUMMARY_MD"
echo "[OK] badge written: $OUTPUT_BADGE_JSON"
