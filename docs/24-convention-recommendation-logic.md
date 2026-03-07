# Convention Recommendation Logic (v1)

업데이트 기준: 2026-03-07

이 문서는 `tools/convention-recommend.sh`의 추천 로직을 정의합니다.
목표는 추천 근거를 설명 가능한 형태로 고정하는 것입니다.

---

## 1) 입력 인터페이스

```bash
./tools/convention-recommend.sh <PROJECT_DIR> --lane <v4.3|v5.0-beta> --mode <auto|existing|greenfield> [--output <path>]
```

입력 파라미터

1. `PROJECT_DIR`: 스캔 대상 경로
2. `--lane`: 버전 라인(`v4.3` 또는 `v5.0-beta`)
3. `--mode`:
- `existing`: 기존 프로젝트로 판단하고 유사도 우선
- `greenfield`: 신규 프로젝트 기본 추천 우선
- `auto`: 스캔 결과로 existing/greenfield 자동 판별
4. `--output`: 마크다운 리포트 출력 경로(기본: `/tmp/convention-recommend-report.md`)

---

## 2) 스캔 시그널

언어/자산 규모

- Java 파일 수
- JS/TS 파일 수
- SQL 파일 수

설정 시그널

- Java: `pom.xml`, `build.gradle*`, `checkstyle*.xml`, `spotless` 키워드
- Spring: `spring-boot` 버전 문자열, `spring-javaformat` 키워드
- JS/TS: `package.json`, `eslint.config.*`, `.eslintrc*`, `.prettierrc*`, `prettier.config.*`
- SQL: `.sqlfluff`

프로젝트 성숙도 시그널

- 코드 파일 수(Java+JS/TS+SQL)
- 빌드/패키지 설정 존재 여부

---

## 3) Auto Mode 판별

`--mode auto`일 때 아래 규칙으로 내부 모드를 결정합니다.

- `total_code_files >= 10` 또는 빌드/패키지 파일 존재: `existing`
- 그 외: `greenfield`

---

## 4) 점수식(프로파일별)

프로파일 후보

- `egov-legacy-safe`
- `egov-java-google`
- `egov-java-spring`
- `egov-ts-prettier-eslint`
- `egov-sql-standard`
- `egov-fullstack-modern`

공통

- lane, mode, 시그널 기반 가산점 합으로 `score` 계산
- 최고 점수 1순위를 `selected_profile`로 선택

핵심 가산 규칙

1. `egov-legacy-safe`
- `lane=v4.3` +40
- `mode=existing` +20
- Java 파일 존재 +15
- formatter/linter 근거 부족 +10

2. `egov-java-google`
- Java 파일 존재 +30
- `google-java-format`/google checkstyle 근거 +25
- `lane=v5.0-beta` +10

3. `egov-java-spring`
- Java 파일 존재 +30
- Spring Boot 3.x 근거 +20
- `spring-javaformat` 근거 +25
- `lane=v5.0-beta` +10

4. `egov-ts-prettier-eslint`
- JS/TS 파일 존재 +30
- eslint 설정 근거 +20
- prettier 설정 근거 +20

5. `egov-sql-standard`
- SQL 파일 3개 이상 +30
- SQL 파일 1~2개 +15
- `.sqlfluff` 근거 +20

6. `egov-fullstack-modern`
- `mode=greenfield` +35
- `lane=v5.0-beta` +20
- Java+JS/TS+SQL 중 2개 이상 존재 +20
- modern 도구 시그널(eslint/prettier/sqlfluff/java format) 존재 +10

---

## 5) 출력 계약

리포트에는 아래 항목을 반드시 포함합니다.

1. `selected_profile`
2. `confidence_score (0-100)`
3. `top_reasons (3개)`
4. `alternatives (최대 2개)`
5. `migration_cost (low|medium|high)`
6. `next_actions`

추가 안내(하이브리드 질문)

- `hybrid_question`: `현재 코드와 최대 유사 / 균형 / 최신 우선`
- `default_if_no_answer`
- `existing`: 유사도 우선
- `greenfield`: `egov-fullstack-modern`

---

## 6) 신뢰도 계산

`confidence_score`는 아래 요소를 반영합니다.

1. 1순위와 2순위 점수 차이
2. 근거 시그널 개수
3. lane/mode 일치 정도

기본 해석

- 80~100: 추천 강함
- 60~79: 추천 가능(대안 함께 검토)
- 0~59: 근거 부족, 수동 확인 필요

---

## 7) 비파괴 원칙

- 스크립트는 파일 수정/생성 없이 읽기 전용 스캔만 수행합니다.
- 출력은 지정된 리포트 파일에만 작성합니다.
- CI 실패 강제 규칙은 추가하지 않습니다.
