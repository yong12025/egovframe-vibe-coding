# Convention Similarity Audit Report

scenario: legacy-v43-java
version_lane: v4.3

## 1) Scan Snapshot

- java_files: 420
- js_ts_files: 8
- sql_files: 16
- detected_mode: existing
- selected_profile(candidate): `egov-legacy-safe`

## 2) Similarity Matrix

| 항목 | 현재 상태 | 프로파일 기준 | 판정 |
|---|---|---|---|
| Java 네이밍 | 혼합(camel/prefix) | 기존 패턴 유지 | 부분 일치 |
| Formatter 도구 | 미도입 | 강제 없음 | 일치 |
| Checkstyle | 일부 모듈만 적용 | 완화 규칙 | 부분 일치 |
| SQL 네이밍 | snake/camel 혼합 | snake 권장(점진) | 부분 불일치 |

## 3) Conflict Priority

### 즉시

1. 신규 파일 네이밍 규칙을 기존 패턴으로 고정
2. 중복/충돌 import 정리

### 점진

1. 모듈 단위로 checkstyle-relaxed 적용
2. SQL 컬럼 네이밍 정렬

### 보류

1. 전면 포맷 재정렬

## 4) Recommendation Contract

- selected_profile: `egov-legacy-safe`
- confidence_score: `91`
- top_reasons:
1. 기존 대형 레거시 코드와 유사도 높음
2. v4.3 라인에서 리스크 최소화에 유리
3. 강제 포맷 없이 점진 도입 가능
- alternatives:
- `egov-java-google`
- `egov-sql-standard`
- migration_cost: `low`
- next_actions:
1. `checkstyle-relaxed.xml`을 신규/변경 파일에만 적용
2. PR에서 기능 변경과 스타일 변경 분리
3. 분기별로 `egov-java-google` 전환 가능성 재평가

## 5) 리스크와 가정

- 리스크: 규칙 완화로 모듈 간 스타일 편차가 남을 수 있음
- 가정: 단기 목표는 안정적 유지보수이며 전면 리포맷은 범위 밖
