#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: ./tools/standard-readiness-check.sh <REPO_DIR> [OUTPUT_MD]" >&2
  exit 1
fi

REPO_DIR="$1"
OUTPUT_MD="${2:-/tmp/standard-readiness-report.md}"

if [[ ! -d "$REPO_DIR" ]]; then
  echo "[ERROR] REPO_DIR not found: $REPO_DIR" >&2
  exit 1
fi

required_files=(
  "README.md"
  "AGENTS.md"
  "CONTRIBUTING.md"
  "CHANGELOG.md"
  "docs/agent-rules.md"
  "docs/12-delivery-checklist.md"
  "docs/23-convention-catalog.md"
  "docs/24-convention-recommendation-logic.md"
  "docs/25-convention-adoption-playbook.md"
  "docs/26-convention-template-pack.md"
  "docs/27-convention-audit-report-samples.md"
  "docs/30-standard-readiness-dashboard.md"
  "docs/31-standard-changelog-policy.md"
  "docs/32-reference-repo-split-operations.md"
  "docs/33-pre-upload-review-standard.md"
  "docs/34-pre-upload-review-report-2026-03-07.md"
  "docs/badges/README.md"
  "docs/badges/standard-readiness-badge.json"
  "prompts/core/06-convention-profile-selection.md"
  "prompts/review/12-convention-similarity-audit.md"
  "prompts/tool-profiles/unified-agent-instruction.md"
  "tools/convention-recommend.sh"
  "tools/common-component-map-audit.sh"
  "tools/migration-lane-check.sh"
  "tools/standard-readiness-dashboard.sh"
  "tools/reference-repo-manifest-check.sh"
  "tools/pre-upload-full-review.sh"
  "examples/convention-templates/README.md"
  "examples/convention-audit-reports/README.md"
  "references/README.md"
  "references/repos.manifest.yml"
  "references/lane-v4.3/README.md"
  "references/lane-v5.0-beta/README.md"
  ".github/workflows/markdown-lint.yml"
  ".github/workflows/link-check.yml"
  ".github/workflows/standard-readiness.yml"
  ".github/workflows/reference-manifest-check.yml"
  ".github/workflows/pre-upload-review.yml"
)

missing=()
for f in "${required_files[@]}"; do
  if [[ ! -e "$REPO_DIR/$f" ]]; then
    missing+=("$f")
  fi
done

# Smoke test: convention recommender
smoke_output="/tmp/standard-readiness-convention.md"
smoke_status="PASS"
smoke_note=""
if [[ -x "$REPO_DIR/tools/convention-recommend.sh" ]]; then
  if ! "$REPO_DIR/tools/convention-recommend.sh" "$REPO_DIR" --lane v5.0-beta --mode auto --output "$smoke_output" >/tmp/standard-readiness-smoke.log 2>&1; then
    smoke_status="FAIL"
    smoke_note="convention-recommend execution failed"
  fi
else
  smoke_status="FAIL"
  smoke_note="tools/convention-recommend.sh is not executable"
fi

selected_profile="N/A"
confidence_score="N/A"
if [[ -f "$smoke_output" ]]; then
  selected_profile="$(rg -n "selected_profile" "$smoke_output" | head -n1 | sed -E 's/.*`([^`]*)`.*/\1/' || true)"
  confidence_score="$(rg -n "confidence_score" "$smoke_output" | head -n1 | sed -E 's/.*`([^`]*)`.*/\1/' || true)"
  selected_profile="${selected_profile:-N/A}"
  confidence_score="${confidence_score:-N/A}"
fi

status="PASS"
if [[ ${#missing[@]} -gt 0 || "$smoke_status" == "FAIL" ]]; then
  status="FAIL"
fi

mkdir -p "$(dirname "$OUTPUT_MD")"

{
  echo "# Standard Readiness Report"
  echo
  echo "generated_at: $(date '+%Y-%m-%d %H:%M:%S %z')"
  echo "repo_dir: $REPO_DIR"
  echo "status: $status"
  echo
  echo "## Required Files"
  echo
  if [[ ${#missing[@]} -eq 0 ]]; then
    echo "- result: PASS"
  else
    echo "- result: FAIL"
    echo "- missing_count: ${#missing[@]}"
    echo "- missing_files:"
    for m in "${missing[@]}"; do
      echo "- $m"
    done
  fi
  echo
  echo "## Convention Recommender Smoke Test"
  echo
  echo "- result: $smoke_status"
  echo "- selected_profile: $selected_profile"
  echo "- confidence_score: $confidence_score"
  if [[ -n "$smoke_note" ]]; then
    echo "- note: $smoke_note"
  fi
  echo
  echo "## Decision"
  echo
  if [[ "$status" == "PASS" ]]; then
    echo "- 표준 repo 기준 충족"
  else
    echo "- 표준 repo 기준 미충족 (누락 항목 보완 필요)"
  fi
} > "$OUTPUT_MD"

echo "[OK] report written: $OUTPUT_MD"
if [[ "$status" == "FAIL" ]]; then
  exit 1
fi
