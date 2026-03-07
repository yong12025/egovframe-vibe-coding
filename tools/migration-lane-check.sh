#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  ./tools/migration-lane-check.sh <PROJECT_DIR> <TARGET_LANE> [OUTPUT_MD]

TARGET_LANE:
  v4.3 | v5.0-beta

Example:
  ./tools/migration-lane-check.sh /path/to/project v5.0-beta /tmp/migration-check.md
USAGE
}

if [ $# -lt 2 ]; then
  usage
  exit 1
fi

PROJECT_DIR="$1"
TARGET_LANE="$2"
OUTPUT_MD="${3:-}"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "[ERROR] PROJECT_DIR not found: $PROJECT_DIR" >&2
  exit 1
fi

case "$TARGET_LANE" in
  v4.3) EXPECTED_BOOT_MAJOR="2" ;;
  v5.0-beta) EXPECTED_BOOT_MAJOR="3" ;;
  *)
    echo "[ERROR] TARGET_LANE must be one of: v4.3, v5.0-beta" >&2
    exit 1
    ;;
esac

if ! command -v rg >/dev/null 2>&1; then
  echo "[ERROR] ripgrep(rg) is required." >&2
  exit 1
fi

TMP_REPORT="$(mktemp)"

write() {
  printf "%s\n" "$1" >> "$TMP_REPORT"
}

pom_versions=""
gradle_versions=""

if [ -f "$PROJECT_DIR/pom.xml" ]; then
  pom_versions="$(rg -No '<version>[0-9]+\.[0-9]+\.[0-9]+' "$PROJECT_DIR/pom.xml" | rg -No '[0-9]+\.[0-9]+\.[0-9]+' | sort -u | tr '\n' ' ' || true)"
fi

if [ -f "$PROJECT_DIR/build.gradle" ] || [ -f "$PROJECT_DIR/build.gradle.kts" ]; then
  gradle_versions="$(rg -No 'org\.springframework\.boot[^\n]*[0-9]+\.[0-9]+\.[0-9]+' "$PROJECT_DIR/build.gradle" "$PROJECT_DIR/build.gradle.kts" 2>/dev/null | rg -No '[0-9]+\.[0-9]+\.[0-9]+' | sort -u | tr '\n' ' ' || true)"
fi

all_versions="$(printf "%s %s" "$pom_versions" "$gradle_versions" | tr ' ' '\n' | rg '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -u | tr '\n' ' ' || true)"

boot_major="unknown"
if [ -n "$all_versions" ]; then
  boot_major="$(printf "%s" "$all_versions" | tr ' ' '\n' | head -n 1 | cut -d'.' -f1)"
fi

javax_count="$({ rg --hidden --glob '!.git' -n 'import javax\.' "$PROJECT_DIR" 2>/dev/null || true; } | wc -l | tr -d ' ')"
jakarta_count="$({ rg --hidden --glob '!.git' -n 'import jakarta\.' "$PROJECT_DIR" 2>/dev/null || true; } | wc -l | tr -d ' ')"

lane_status="PASS"
lane_note=""

if [ "$boot_major" = "unknown" ]; then
  lane_status="WARN"
  lane_note="Spring Boot 버전 자동 감지 실패(수동 확인 필요)"
elif [ "$boot_major" != "$EXPECTED_BOOT_MAJOR" ]; then
  lane_status="FAIL"
  lane_note="목표 라인($TARGET_LANE)과 Boot 메이저($boot_major) 불일치"
fi

javax_status="INFO"
jakarta_status="INFO"

if [ "$TARGET_LANE" = "v5.0-beta" ] && [ "$javax_count" -gt 0 ]; then
  javax_status="FAIL"
fi

if [ "$TARGET_LANE" = "v4.3" ] && [ "$jakarta_count" -gt 0 ]; then
  jakarta_status="WARN"
fi

write "# Migration Lane Check Report"
write ""
write "- 대상 경로: $PROJECT_DIR"
write "- 목표 라인: $TARGET_LANE"
write "- 실행 시각: $(date '+%Y-%m-%d %H:%M:%S %z')"
write ""
write "## Summary"
write ""
write "| 항목 | 상태 | 메모 |"
write "|---|---|---|"
write "| 버전 라인 정합성 | $lane_status | ${lane_note:-정상} |"
write "| javax 사용량 | $javax_status | count=$javax_count |"
write "| jakarta 사용량 | $jakarta_status | count=$jakarta_count |"
write ""
write "## Detected Versions"
write ""
write "- pom.xml candidates: ${pom_versions:-none}"
write "- gradle candidates: ${gradle_versions:-none}"
write "- detected boot major: $boot_major"
write ""
write "## Recommended Actions"
write ""

if [ "$lane_status" = "FAIL" ]; then
  write "1. 목표 라인에 맞는 Spring Boot 메이저로 의존성을 정렬하세요."
  write "2. prompts/core/02-version-lock.md를 사용해 충돌 후보를 재정리하세요."
else
  write "1. 버전 라인 기준으로 큰 충돌은 탐지되지 않았습니다."
fi

if [ "$javax_status" = "FAIL" ]; then
  write "3. v5.0-beta 전환 시 javax.* -> jakarta.* 전환 계획을 우선 수립하세요."
fi

if [ "$jakarta_status" = "WARN" ]; then
  write "3. v4.3 라인에서 jakarta.* 사용 영역의 호환성 검토가 필요합니다."
fi

write ""
write "## Verify Commands"
write ""
write '```bash'
write "./tools/migration-lane-check.sh $PROJECT_DIR $TARGET_LANE"
write '```'

if [ -n "$OUTPUT_MD" ]; then
  cp "$TMP_REPORT" "$OUTPUT_MD"
  echo "[OK] report written: $OUTPUT_MD"
else
  cat "$TMP_REPORT"
fi

rm -f "$TMP_REPORT"
