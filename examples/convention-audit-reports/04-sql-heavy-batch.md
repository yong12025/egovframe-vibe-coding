# Convention Similarity Audit Report

scenario: sql-heavy-batch
version_lane: v5.0-beta

## 1) Scan Snapshot

- java_files: 92
- js_ts_files: 0
- sql_files: 140
- detected_mode: existing
- selected_profile(candidate): `egov-sql-standard`

## 2) Similarity Matrix

| 항목 | 현재 상태 | 프로파일 기준 | 판정 |
|---|---|---|---|
| SQL keyword case | 혼합 | UPPER | 불일치 |
| 식별자 네이밍 | snake/camel 혼합 | snake_case | 부분 불일치 |
| SQL lint | 미도입 | sqlfluff | 불일치 |
| 배치 재처리 쿼리 | 분리 관리 | 유지 | 일치 |

## 3) Conflict Priority

### 즉시

1. `.sqlfluff` 기본 규칙 추가
2. 신규 SQL 파일 키워드 대문자 규칙 적용

### 점진

1. 고빈도 배치 쿼리부터 snake_case 정렬
2. 긴 쿼리 라인 길이 정리

### 보류

1. 전체 히스토리 SQL 일괄 정렬

## 4) Recommendation Contract

- selected_profile: `egov-sql-standard`
- confidence_score: `97`
- top_reasons:
1. SQL 자산 비중이 매우 높음
2. 쿼리 리뷰/운영 장애 분석에 표준화 효과 큼
3. 신규 SQL부터 적용하면 리스크 관리 가능
- alternatives:
- `egov-java-spring`
- `egov-fullstack-modern`
- migration_cost: `medium`
- next_actions:
1. 핵심 배치 모듈에 sqlfluff 리포트 우선 적용
2. 운영 장애 빈도 높은 쿼리부터 정렬
3. PR 템플릿에 SQL 표준 점검 항목 추가

## 5) 리스크와 가정

- 리스크: 대규모 쿼리 정리 시 실행 계획 변화 가능
- 가정: 성능 영향 검증은 별도 쿼리 플랜 리뷰로 수행
