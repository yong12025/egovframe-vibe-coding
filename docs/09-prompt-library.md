# Prompt Library Guide

자동 코드 생성을 위한 프롬프트 사용 가이드입니다.

---

## 목표

- 프롬프트 결과물의 편차를 줄인다.
- 버전 혼합 없이 일관된 산출물을 만든다.
- 리뷰 가능한 파일 단위 결과를 얻는다.

---

## 디렉터리

- `prompts/core`: 시작/버전 잠금/컨벤션 선택/재사용 감사
- `prompts/generators`: 코드 생성
- `prompts/review`: 구조/보안/마이그레이션 점검
- `prompts/tool-profiles`: 단일 시작 지시문

---

## 추천 실행 순서

1. `prompts/core/01-project-kickoff.md`
2. `prompts/core/02-version-lock.md`
3. `prompts/core/06-convention-profile-selection.md`
4. `prompts/core/03-reuse-audit.md`
5. 목적별 생성 프롬프트
6. `prompts/review/01-architecture-review.md`
7. `prompts/review/02-security-review.md`

---

## 대표 프롬프트

### 컨벤션 선택

- `prompts/core/06-convention-profile-selection.md`

### CRUD 생성

- `prompts/generators/01-crud-from-ddl.md`

### 로그인/권한

- `prompts/generators/02-login-rbac.md`

### 게시판 재사용

- `prompts/generators/03-board-reuse.md`

### 배치

- `prompts/generators/04-batch-job.md`

### API 우선

- `prompts/generators/05-rest-api-first.md`

### 테스트 생성

- `prompts/generators/06-test-generation.md`

### 2차 팩(추가 생성/운영)

- `prompts/generators/07-file-upload-module.md`
- `prompts/generators/08-common-code-management.md`
- `prompts/generators/09-menu-role-mapping.md`
- `prompts/generators/10-audit-log-pipeline.md`
- `prompts/generators/11-search-module.md`
- `prompts/generators/12-openapi-contract-sync.md`
- `prompts/generators/13-admin-dashboard-scaffold.md`
- `prompts/generators/14-batch-retry-recovery.md`

### 2차 팩(추가 리뷰/진단)

- `prompts/review/04-troubleshooting-auto-diagnosis.md`
- `prompts/review/05-performance-bottleneck-review.md`
- `prompts/review/06-dependency-conflict-audit.md`
- `prompts/review/07-db-query-plan-review.md`
- `prompts/review/08-release-readiness-gate.md`
- `prompts/review/09-observability-review.md`
- `prompts/review/10-test-gap-analysis.md`
- `prompts/review/11-incident-postmortem.md`
- `prompts/review/12-convention-similarity-audit.md`

### 단일 시작 지시문

- `prompts/tool-profiles/unified-agent-instruction.md`

---

## 검수 규칙

프롬프트 출력이 아래를 포함하지 않으면 재요청합니다.

1. 버전 라인 선언
2. `selected_profile` / `confidence_score`
3. `top_reasons` / `alternatives`
4. 변경 파일 목록
5. 실행/검증 명령
6. 보안/리스크 체크
