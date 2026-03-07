# Convention Similarity Audit Report

scenario: boot3-spring-service
version_lane: v5.0-beta

## 1) Scan Snapshot

- java_files: 180
- js_ts_files: 0
- sql_files: 12
- detected_mode: existing
- selected_profile(candidate): `egov-java-spring`

## 2) Similarity Matrix

| 항목 | 현재 상태 | 프로파일 기준 | 판정 |
|---|---|---|---|
| Spring Boot | 3.3.x | Boot 3.x 정렬 | 일치 |
| Java 스타일 | 팀 커스텀 포맷 | spring-javaformat | 부분 불일치 |
| Exception 구조 | 표준화됨 | 유지 | 일치 |
| SQL 스타일 | snake 중심 | snake 권장 | 일치 |

## 3) Conflict Priority

### 즉시

1. 신규 파일에 `.springjavaformatconfig` 기준 적용
2. Controller/Service 계층 import 순서 통일

### 점진

1. 핵심 모듈부터 spring-javaformat 도입
2. CI에는 경고 리포트만 첨부

### 보류

1. 전체 모듈 일괄 포맷

## 4) Recommendation Contract

- selected_profile: `egov-java-spring`
- confidence_score: `89`
- top_reasons:
1. Spring Boot 3.x와 정합성 높음
2. v5.0-beta 라인에서 운영 표준과 일치
3. 기존 구조를 크게 흔들지 않고 적용 가능
- alternatives:
- `egov-java-google`
- `egov-fullstack-modern`
- migration_cost: `medium`
- next_actions:
1. `spotless-spring.gradle.snippet`을 참조해 파일 범위 제한 적용
2. 리뷰 단계에 컨벤션 유사도 리포트 고정 첨부
3. 2주 단위로 위반 유형 통계를 기록

## 5) 리스크와 가정

- 리스크: 기존 커스텀 스타일과 충돌 시 초기 리뷰 비용 증가
- 가정: 신규 기능 추가가 포맷 대규모 변경보다 우선
