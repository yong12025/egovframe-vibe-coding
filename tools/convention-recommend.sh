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

usage() {
  cat <<'USAGE'
Usage:
  ./tools/convention-recommend.sh <PROJECT_DIR> --lane <v4.3|v5.0-beta> --mode <auto|existing|greenfield> [--output <path>]
USAGE
}

if [[ $# -lt 5 ]]; then
  usage
  exit 1
fi

PROJECT_DIR="$(normalize_path "$1")"
shift

LANE=""
MODE=""
OUTPUT="/tmp/convention-recommend-report.md"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --lane)
      LANE="${2:-}"
      shift 2
      ;;
    --mode)
      MODE="${2:-}"
      shift 2
      ;;
    --output)
      OUTPUT="$(normalize_path "${2:-}")"
      shift 2
      ;;
    *)
      echo "[ERROR] unknown arg: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ ! -d "$PROJECT_DIR" ]]; then
  echo "[ERROR] PROJECT_DIR not found: $PROJECT_DIR" >&2
  exit 1
fi

if [[ "$LANE" != "v4.3" && "$LANE" != "v5.0-beta" ]]; then
  echo "[ERROR] --lane must be v4.3 or v5.0-beta" >&2
  exit 1
fi

if [[ "$MODE" != "auto" && "$MODE" != "existing" && "$MODE" != "greenfield" ]]; then
  echo "[ERROR] --mode must be auto|existing|greenfield" >&2
  exit 1
fi

count_files() {
  local globs=()
  local result
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -g)
        globs+=("${2:-}")
        shift 2
        ;;
      *)
        shift
        ;;
    esac
  done
  if [[ -n "${RG_BIN:-}" ]]; then
    local rg_args=()
    local glob
    for glob in "${globs[@]}"; do
      rg_args+=(-g "$glob")
    done
    result="$("$RG_BIN" --files "${rg_args[@]}" "$PROJECT_DIR" 2>/dev/null | wc -l | awk '{print $1}' || true)"
    echo "${result:-0}"
    return
  fi
  local find_args=()
  local i
  if [[ ${#globs[@]} -gt 0 ]]; then
    find_args+=("(")
    for (( i=0; i<${#globs[@]}; i++ )); do
      if (( i > 0 )); then
        find_args+=(-o)
      fi
      find_args+=(-name "${globs[$i]}")
    done
    find_args+=(")")
  fi
  result="$(find "$PROJECT_DIR" -type f "${find_args[@]}" 2>/dev/null | wc -l | awk '{print $1}' || true)"
  echo "${result:-0}"
}

exists_file() {
  find "$PROJECT_DIR" -type f "$@" 2>/dev/null | head -n 1
}

has_pattern() {
  local pattern="$1"
  shift
  local globs=()
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --glob)
        globs+=("${2:-}")
        shift 2
        ;;
      *)
        shift
        ;;
    esac
  done
  if [[ -n "${RG_BIN:-}" ]]; then
    local rg_args=()
    local glob
    for glob in "${globs[@]}"; do
      rg_args+=(--glob "$glob")
    done
    if "$RG_BIN" -n "${rg_args[@]}" "$pattern" "$PROJECT_DIR" >/dev/null 2>&1; then
      echo 1
    else
      echo 0
    fi
    return
  fi
  local grep_args=(-RInE)
  local glob
  for glob in "${globs[@]}"; do
    grep_args+=("--include=$glob")
  done
  grep_args+=("$pattern" "$PROJECT_DIR")
  if grep "${grep_args[@]}" >/dev/null 2>&1; then
    echo 1
  else
    echo 0
  fi
}

RG_BIN="$(resolve_rg || true)"

java_files="$(count_files -g '*.java')"
js_ts_files="$(count_files -g '*.js' -g '*.jsx' -g '*.ts' -g '*.tsx')"
sql_files="$(count_files -g '*.sql')"
total_code_files=$((java_files + js_ts_files + sql_files))

pom_exists=0
if [[ -n "$(exists_file -name 'pom.xml')" ]]; then
  pom_exists=1
fi

gradle_exists=0
if [[ -n "$(exists_file \( -name 'build.gradle' -o -name 'build.gradle.kts' \))" ]]; then
  gradle_exists=1
fi

package_json_exists=0
if [[ -n "$(exists_file -name 'package.json')" ]]; then
  package_json_exists=1
fi

checkstyle_exists=0
if [[ -n "$(exists_file \( -name 'checkstyle.xml' -o -name 'checkstyle-*.xml' \))" ]]; then
  checkstyle_exists=1
fi

google_java_format_signal="$(has_pattern 'google-java-format|googleJavaFormat' --glob 'pom.xml' --glob 'build.gradle' --glob 'build.gradle.kts')"
spring_javaformat_signal="$(has_pattern 'spring-javaformat|springJavaFormat' --glob 'pom.xml' --glob 'build.gradle' --glob 'build.gradle.kts')"
spring_boot3_signal="$(has_pattern 'spring-boot[^0-9]*3\.|spring-boot-starter-parent[^0-9]*3\.|org\.springframework\.boot[^0-9]*3\.' --glob 'pom.xml' --glob 'build.gradle' --glob 'build.gradle.kts')"
spotless_signal="$(has_pattern 'spotless' --glob 'pom.xml' --glob 'build.gradle' --glob 'build.gradle.kts')"

eslint_exists=0
if [[ -n "$(exists_file \( -name 'eslint.config.js' -o -name 'eslint.config.mjs' -o -name 'eslint.config.cjs' -o -name '.eslintrc' -o -name '.eslintrc.js' -o -name '.eslintrc.cjs' -o -name '.eslintrc.json' -o -name '.eslintrc.yml' -o -name '.eslintrc.yaml' \))" ]]; then
  eslint_exists=1
fi

prettier_exists=0
if [[ -n "$(exists_file \( -name '.prettierrc' -o -name '.prettierrc.js' -o -name '.prettierrc.cjs' -o -name '.prettierrc.json' -o -name '.prettierrc.yml' -o -name '.prettierrc.yaml' -o -name 'prettier.config.js' -o -name 'prettier.config.cjs' -o -name 'prettier.config.mjs' \))" ]]; then
  prettier_exists=1
fi

sqlfluff_exists=0
if [[ -n "$(exists_file -name '.sqlfluff')" ]]; then
  sqlfluff_exists=1
fi

build_or_package_exists=0
if [[ $pom_exists -eq 1 || $gradle_exists -eq 1 || $package_json_exists -eq 1 ]]; then
  build_or_package_exists=1
fi

MODE_EFFECTIVE="$MODE"
if [[ "$MODE" == "auto" ]]; then
  if [[ $total_code_files -ge 10 || $build_or_package_exists -eq 1 ]]; then
    MODE_EFFECTIVE="existing"
  else
    MODE_EFFECTIVE="greenfield"
  fi
fi

# Profile index mapping
# 0 legacy-safe
# 1 java-google
# 2 java-spring
# 3 ts-prettier-eslint
# 4 sql-standard
# 5 fullstack-modern
names=(
  "egov-legacy-safe"
  "egov-java-google"
  "egov-java-spring"
  "egov-ts-prettier-eslint"
  "egov-sql-standard"
  "egov-fullstack-modern"
)

scores=(0 0 0 0 0 0)
reasons=("" "" "" "" "" "")

add_score() {
  local idx="$1"
  local points="$2"
  local reason="$3"
  scores[$idx]=$((scores[$idx] + points))
  reasons[$idx]="${reasons[$idx]}- ${reason} (+${points})\n"
}

# Base scoring rules
if [[ "$LANE" == "v4.3" ]]; then
  add_score 0 40 "v4.3 lane aligns with legacy-safe"
fi
if [[ "$MODE_EFFECTIVE" == "existing" ]]; then
  add_score 0 20 "existing project mode favors similarity-first"
fi
if [[ $java_files -gt 0 ]]; then
  add_score 0 15 "Java codebase detected"
fi
if [[ $google_java_format_signal -eq 0 && $spring_javaformat_signal -eq 0 && $spotless_signal -eq 0 && $checkstyle_exists -eq 0 ]]; then
  add_score 0 10 "formatter/linter evidence is limited"
fi

if [[ $java_files -gt 0 ]]; then
  add_score 1 30 "Java code detected"
fi
if [[ $google_java_format_signal -eq 1 ]]; then
  add_score 1 25 "google-java-format signal detected"
fi
if [[ $checkstyle_exists -eq 1 ]]; then
  add_score 1 10 "checkstyle config detected"
fi
if [[ "$LANE" == "v5.0-beta" ]]; then
  add_score 1 10 "v5 lane often aligns with stronger formatter standard"
fi

if [[ $java_files -gt 0 ]]; then
  add_score 2 30 "Java code detected"
fi
if [[ $spring_boot3_signal -eq 1 ]]; then
  add_score 2 20 "Spring Boot 3 signal detected"
fi
if [[ $spring_javaformat_signal -eq 1 ]]; then
  add_score 2 25 "spring-javaformat signal detected"
fi
if [[ "$LANE" == "v5.0-beta" ]]; then
  add_score 2 10 "v5 lane aligns with spring-javaformat adoption"
fi

if [[ $js_ts_files -gt 0 ]]; then
  add_score 3 30 "JS/TS files detected"
fi
if [[ $eslint_exists -eq 1 ]]; then
  add_score 3 20 "ESLint config detected"
fi
if [[ $prettier_exists -eq 1 ]]; then
  add_score 3 20 "Prettier config detected"
fi

if [[ $sql_files -ge 3 ]]; then
  add_score 4 30 "SQL files(>=3) detected"
elif [[ $sql_files -gt 0 ]]; then
  add_score 4 15 "SQL files(1-2) detected"
fi
if [[ $sqlfluff_exists -eq 1 ]]; then
  add_score 4 20 "sqlfluff config detected"
fi

if [[ "$MODE_EFFECTIVE" == "greenfield" ]]; then
  add_score 5 35 "greenfield mode favors fullstack modern baseline"
fi
if [[ "$LANE" == "v5.0-beta" ]]; then
  add_score 5 20 "v5 lane aligns with modern fullstack profile"
fi
stack_count=0
if [[ $java_files -gt 0 ]]; then
  stack_count=$((stack_count + 1))
fi
if [[ $js_ts_files -gt 0 ]]; then
  stack_count=$((stack_count + 1))
fi
if [[ $sql_files -gt 0 ]]; then
  stack_count=$((stack_count + 1))
fi
if [[ $stack_count -ge 2 ]]; then
  add_score 5 20 "multi-stack signal detected"
fi
modern_signal_count=0
if [[ $eslint_exists -eq 1 ]]; then modern_signal_count=$((modern_signal_count + 1)); fi
if [[ $prettier_exists -eq 1 ]]; then modern_signal_count=$((modern_signal_count + 1)); fi
if [[ $sqlfluff_exists -eq 1 ]]; then modern_signal_count=$((modern_signal_count + 1)); fi
if [[ $google_java_format_signal -eq 1 || $spring_javaformat_signal -eq 1 ]]; then modern_signal_count=$((modern_signal_count + 1)); fi
if [[ $modern_signal_count -gt 0 ]]; then
  add_score 5 10 "modern tooling signals detected"
fi

# Select top 3 profiles
best_idx=0
second_idx=1
third_idx=2
for i in 0 1 2 3 4 5; do
  if [[ ${scores[$i]} -gt ${scores[$best_idx]} ]]; then
    third_idx=$second_idx
    second_idx=$best_idx
    best_idx=$i
  elif [[ $i -ne $best_idx && ${scores[$i]} -gt ${scores[$second_idx]} ]]; then
    third_idx=$second_idx
    second_idx=$i
  elif [[ $i -ne $best_idx && $i -ne $second_idx && ${scores[$i]} -gt ${scores[$third_idx]} ]]; then
    third_idx=$i
  fi
done

selected_profile="${names[$best_idx]}"
alt1="${names[$second_idx]}"
alt2="${names[$third_idx]}"

diff=$((scores[$best_idx] - scores[$second_idx]))
signal_count=0
for v in $pom_exists $gradle_exists $package_json_exists $checkstyle_exists $google_java_format_signal $spring_javaformat_signal $spring_boot3_signal $spotless_signal $eslint_exists $prettier_exists $sqlfluff_exists; do
  if [[ "$v" -eq 1 ]]; then
    signal_count=$((signal_count + 1))
  fi
done

confidence=$((55 + diff * 2 + signal_count * 2))
if [[ ${scores[$best_idx]} -lt 25 ]]; then
  confidence=$((confidence - 12))
fi
if [[ $confidence -gt 100 ]]; then confidence=100; fi
if [[ $confidence -lt 0 ]]; then confidence=0; fi

migration_cost="medium"
case "$selected_profile" in
  egov-legacy-safe)
    migration_cost="low"
    ;;
  egov-java-google)
    if [[ "$MODE_EFFECTIVE" == "existing" && $java_files -ge 200 ]]; then
      migration_cost="high"
    else
      migration_cost="medium"
    fi
    ;;
  egov-java-spring)
    if [[ "$MODE_EFFECTIVE" == "existing" && $java_files -ge 200 ]]; then
      migration_cost="high"
    else
      migration_cost="medium"
    fi
    ;;
  egov-ts-prettier-eslint)
    if [[ "$MODE_EFFECTIVE" == "existing" && $js_ts_files -ge 150 ]]; then
      migration_cost="medium"
    else
      migration_cost="low"
    fi
    ;;
  egov-sql-standard)
    if [[ $sql_files -ge 40 ]]; then
      migration_cost="medium"
    else
      migration_cost="low"
    fi
    ;;
  egov-fullstack-modern)
    if [[ "$MODE_EFFECTIVE" == "greenfield" ]]; then
      migration_cost="low"
    else
      migration_cost="high"
    fi
    ;;
esac

next_actions=""
case "$selected_profile" in
  egov-legacy-safe)
    next_actions=$'1. 기존 코드 네이밍/패키지 규칙을 기준으로 변경 파일만 정렬\n2. 공통컴포넌트 재사용 여부를 먼저 확정\n3. 대규모 일괄 포맷은 보류하고 모듈 단위로 점진 적용'
    ;;
  egov-java-google)
    next_actions=$'1. google-java-format 적용 범위를 신규/변경 파일로 제한\n2. checkstyle google 규칙과 충돌 항목 목록화\n3. 첫 PR에서 포맷 변경과 기능 변경을 분리'
    ;;
  egov-java-spring)
    next_actions=$'1. spring-javaformat 적용 대상을 신규/변경 파일로 제한\n2. Boot 3.x/Spring 6 스타일과 현재 코드 차이를 점검\n3. 운영 문서와 네이밍 규칙을 함께 정렬'
    ;;
  egov-ts-prettier-eslint)
    next_actions=$'1. ESLint Flat Config와 Prettier 역할 분리\n2. 자동 수정은 신규/변경 파일부터 적용\n3. API 계약 DTO 네이밍 일관성 점검'
    ;;
  egov-sql-standard)
    next_actions=$'1. SQLFluff core 규칙만 먼저 적용\n2. snake_case 위반 구간을 우선 식별\n3. 쿼리 리팩터링과 인덱스 전략을 분리 리뷰'
    ;;
  egov-fullstack-modern)
    next_actions=$'1. Java/JS/TS/SQL 컨벤션을 동시에 선언\n2. 생성 프롬프트에 selected_profile을 고정 전달\n3. 리뷰 단계에서 컨벤션 유사도 감사 리포트 첨부'
    ;;
esac

# Top reasons (exactly 3 lines, fallback included)
raw_reasons="${reasons[$best_idx]}"
top_reason_1="$(printf "%b" "$raw_reasons" | sed -n '1p')"
top_reason_2="$(printf "%b" "$raw_reasons" | sed -n '2p')"
top_reason_3="$(printf "%b" "$raw_reasons" | sed -n '3p')"
if [[ -z "$top_reason_1" ]]; then top_reason_1="- lane/mode 기본 규칙 기반 추천"; fi
if [[ -z "$top_reason_2" ]]; then top_reason_2="- 파일 시그널 근거가 제한적이어서 보수 추천"; fi
if [[ -z "$top_reason_3" ]]; then top_reason_3="- hybrid 질문으로 최종 확정 필요"; fi

mkdir -p "$(dirname "$OUTPUT")"

cat > "$OUTPUT" <<REPORT
# Convention Recommendation Report

generated_at: $(date '+%Y-%m-%d %H:%M:%S %z')
project_dir: $PROJECT_DIR
lane: $LANE
requested_mode: $MODE
detected_mode: $MODE_EFFECTIVE

## Recommendation Contract

REPORT

# Build report body separately to avoid escaping mistakes
{
  echo "- selected_profile: \`$selected_profile\`"
  echo "- confidence_score: \`$confidence\`"
  echo "- migration_cost: \`$migration_cost\`"
  echo
  echo "- top_reasons:"
  echo "1. ${top_reason_1#- }"
  echo "2. ${top_reason_2#- }"
  echo "3. ${top_reason_3#- }"
  echo
  echo "- alternatives:"
  echo "- \`$alt1\`"
  echo "- \`$alt2\`"
  echo
  echo "- next_actions:"
  printf "%b\n" "$next_actions"
  echo
  echo "## Hybrid Question"
  echo
  echo "- hybrid_question: \`현재 코드와 최대 유사 / 균형 / 최신 우선 중 무엇으로 확정할까요?\`"
  if [[ "$MODE_EFFECTIVE" == "existing" ]]; then
    echo "- default_if_no_answer: \`유사도 우선\`"
  else
    echo "- default_if_no_answer: \`egov-fullstack-modern\`"
  fi
  echo
  echo "## Scan Snapshot"
  echo
  echo "- java_files: $java_files"
  echo "- js_ts_files: $js_ts_files"
  echo "- sql_files: $sql_files"
  echo "- build_or_package_exists: $build_or_package_exists"
  echo
  echo "## Scoreboard"
  echo
  for i in 0 1 2 3 4 5; do
    echo "- ${names[$i]}: ${scores[$i]}"
  done
} >> "$OUTPUT"

echo "[OK] report written: $OUTPUT"
