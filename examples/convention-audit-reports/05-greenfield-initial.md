# Convention Similarity Audit Report

scenario: greenfield-initial
version_lane: v5.0-beta

## 1) Scan Snapshot

- java_files: 0
- js_ts_files: 0
- sql_files: 1
- detected_mode: greenfield
- selected_profile(candidate): `egov-fullstack-modern`

## 2) Similarity Matrix

| 항목 | 현재 상태 | 프로파일 기준 | 판정 |
|---|---|---|---|
| 코드 자산 | 초기(거의 없음) | 신규 표준 선적용 | 일치 |
| Java 컨벤션 | 미정 | google 또는 spring 중 선택 | 보류 |
| JS/TS 컨벤션 | 미정 | eslint + prettier | 보류 |
| SQL 컨벤션 | 기본 스키마만 존재 | sqlfluff core | 부분 일치 |

## 3) Conflict Priority

### 즉시

1. `egov-fullstack-modern` 기본 채택
2. Java 세부 프로파일(`google` 또는 `spring`) 확정

### 점진

1. 첫 모듈 생성 시 언어별 템플릿 적용
2. 팀 합의 후 경고 리포트 자동 첨부

### 보류

1. CI fail-fast 강제

## 4) Recommendation Contract

- selected_profile: `egov-fullstack-modern`
- confidence_score: `100`
- top_reasons:
1. greenfield 모드에서 기본 프로파일 정책과 일치
2. 다중 스택 확장 가능성을 초기부터 반영 가능
3. 가이드 전용으로 도입 리스크가 낮음
- alternatives:
- `egov-java-spring`
- `egov-java-google`
- migration_cost: `low`
- next_actions:
1. `examples/convention-templates/`의 조합 템플릿 적용
2. 첫 기능 PR부터 Recommendation Contract 포함
3. 스프린트 종료 시 유사도 감사 리포트 1회 생성

## 5) 리스크와 가정

- 리스크: Java 세부 프로파일 미확정 상태가 길어지면 팀 편차 확대
- 가정: 1~2개 모듈 구현 후 세부 프로파일을 최종 고정
