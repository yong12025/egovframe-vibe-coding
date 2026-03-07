# Convention Similarity Audit Report

scenario: ts-ui-module
version_lane: v5.0-beta

## 1) Scan Snapshot

- java_files: 35
- js_ts_files: 210
- sql_files: 4
- detected_mode: existing
- selected_profile(candidate): `egov-ts-prettier-eslint`

## 2) Similarity Matrix

| 항목 | 현재 상태 | 프로파일 기준 | 판정 |
|---|---|---|---|
| ESLint | legacy `.eslintrc` | flat config 권장 | 부분 불일치 |
| Prettier | 일부 패키지 적용 | 전역 단일 설정 | 부분 불일치 |
| TS strict | 모듈별 상이 | 점진 강화 | 부분 일치 |
| API DTO 네이밍 | camelCase 중심 | 유지 | 일치 |

## 3) Conflict Priority

### 즉시

1. 루트 `eslint.config.mjs` 기준 통합
2. `.prettierrc.json` 단일화

### 점진

1. 패키지별 lint 경고를 순차 해소
2. 타입 엄격도 옵션 단계적 강화

### 보류

1. 레거시 UI 전체 재정렬

## 4) Recommendation Contract

- selected_profile: `egov-ts-prettier-eslint`
- confidence_score: `94`
- top_reasons:
1. JS/TS 자산 비중이 높음
2. eslint/prettier 시그널이 이미 존재
3. UI 모듈 품질 편차를 빠르게 줄일 수 있음
- alternatives:
- `egov-fullstack-modern`
- `egov-legacy-safe`
- migration_cost: `medium`
- next_actions:
1. 신규/변경 파일부터 자동 포맷 적용
2. 린트 오류는 경고 중심으로 2스프린트 운영
3. 공통 UI 패키지부터 strict rules 적용

## 5) 리스크와 가정

- 리스크: 모듈별 기존 규칙 차이로 초기 경고량 증가
- 가정: 릴리스 안정성 때문에 즉시 fail-fast는 사용하지 않음
