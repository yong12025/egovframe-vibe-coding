# Example: New Boot Service

신규 Boot 기반 서비스 시작 예시입니다.

## Scenario

- 버전 라인: v5.0 beta
- 목표: 공지사항 모듈 CRUD + 로그인
- 방식: Prompt-driven generation

## Steps

1. `prompts/core/01-project-kickoff.md`
2. `prompts/core/02-version-lock.md`
3. `prompts/core/06-convention-profile-selection.md`
4. `prompts/generators/01-crud-from-ddl.md`
5. `prompts/generators/02-login-rbac.md`
6. `prompts/review/12-convention-similarity-audit.md`
7. `prompts/review/02-security-review.md`

## Deliverables

- selected_profile / confidence_score
- top_reasons / alternatives
- 생성 파일 목록
- 실행 명령
- 검수 체크리스트
- 샘플 DDL: `schema.sql`
- 샘플 산출물: `DELIVERY_SAMPLE.md`
- 유사도 감사 샘플: `../convention-audit-reports/02-boot3-spring-service.md`
