# Convention Catalog (v1)

업데이트 기준: 2026-03-07

이 문서는 eGovFrame 프로젝트에서 선택 가능한 코드 컨벤션 프로파일을 정의합니다.
목표는 "최신성"과 "기존 코드 유사성" 사이의 혼란을 줄이는 것입니다.

---

## 1) 선택 원칙

1. 기존 프로젝트: 현재 코드 유사도 우선
2. 신규/초기 프로젝트: `egov-fullstack-modern` 기본
3. 적용 강도: 가이드 전용(강제 실패 없음)

---

## 2) Profile: `egov-legacy-safe`

대상

- v4.3 레거시 유지/점진 개선

핵심 규칙

- 기존 네이밍/패키지 패턴 유지
- 변경 파일만 국소 정리
- 포매터/룰 도입은 권고만 수행

권장 도구

- Checkstyle (완화 규칙)
- 선택적 Spotless/formatter dry-run

마이그레이션 비용

- low

---

## 3) Profile: `egov-java-google`

대상

- Java 중심 코드베이스
- 팀 표준을 Google Java Style로 통일하려는 경우

핵심 규칙

- `google-java-format` 기반 포맷 일관화
- Checkstyle Google 스타일 규칙 참조

권장 도구

- `google-java-format`
- Checkstyle Google 설정

마이그레이션 비용

- medium(레거시 코드 정렬 시 high 가능)

---

## 4) Profile: `egov-java-spring`

대상

- Spring Boot 3.x / Spring 6 중심
- Spring 생태계 표준 정렬이 필요한 경우

핵심 규칙

- `spring-javaformat` 기반 정렬
- Spring 스타일과 운영 표준 문서 일치

권장 도구

- `spring-javaformat`
- Checkstyle/Spotless 보조 적용

마이그레이션 비용

- medium

---

## 5) Profile: `egov-ts-prettier-eslint`

대상

- 프런트엔드 또는 Node 계층 포함 프로젝트

핵심 규칙

- ESLint Flat Config 우선
- Prettier를 단일 포맷터로 사용

권장 도구

- ESLint (`eslint.config.*`)
- Prettier (`.prettierrc*`)

마이그레이션 비용

- low~medium

---

## 6) Profile: `egov-sql-standard`

대상

- SQL 파일/쿼리 리뷰 비중이 높은 프로젝트

핵심 규칙

- SQLFluff core rules 우선
- 스키마/컬럼 snake_case 기본

권장 도구

- SQLFluff (`.sqlfluff`)

마이그레이션 비용

- low(규칙 확장 시 medium)

---

## 7) Profile: `egov-fullstack-modern`

대상

- 신규 프로젝트(권장 기본)
- Java + JS/TS + SQL 혼합 스택

조합

- `egov-java-google` 또는 `egov-java-spring`
- `egov-ts-prettier-eslint`
- `egov-sql-standard`

핵심 규칙

- 계층별 도구는 분리, 출력 계약은 통일
- 신규 파일부터 일관성 유지

마이그레이션 비용

- 신규: low
- 기존 대형 코드베이스: high

---

## 8) 빠른 선택 가이드

1. v4.3 레거시 유지가 최우선이면 `egov-legacy-safe`
2. Java 중심 + 강한 포맷 통일이면 `egov-java-google`
3. Spring Boot 3 표준 정렬이면 `egov-java-spring`
4. JS/TS 비중이 높으면 `egov-ts-prettier-eslint` 병행
5. SQL 리뷰 부담이 크면 `egov-sql-standard` 추가
6. 신규/초기 프로젝트는 `egov-fullstack-modern`

---

## 9) 공식 레퍼런스

- https://www.egovframe.go.kr/home/sub.do?menuNo=12
- https://github.com/google/google-java-format
- https://github.com/spring-io/spring-javaformat
- https://checkstyle.sourceforge.io/google_style.html
- https://eslint.org/docs/latest/use/configure/configuration-files
- https://prettier.io/docs/options
- https://docs.sqlfluff.com/en/stable/reference/rules.html

템플릿 적용 가이드

- `docs/26-convention-template-pack.md`
