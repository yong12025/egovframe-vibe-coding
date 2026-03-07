# Example: MSA Domain Split

도메인 분리 기반 MSA 초기 설계 예시입니다.

## Scenario

- 버전 라인: v5.0 beta
- 시작점: MSA
- 목표: 사용자/게시물/인증 도메인 경계 정의와 API 계약 수립

## Steps

1. `prompts/core/01-project-kickoff.md`
2. `prompts/core/02-version-lock.md`
3. `prompts/core/06-convention-profile-selection.md`
4. `prompts/generators/05-rest-api-first.md`
5. `prompts/review/12-convention-similarity-audit.md`
6. `prompts/review/03-migration-v43-to-v50.md`

## Deliverables

- selected_profile / confidence_score
- top_reasons / alternatives
- 도메인 경계/책임 표
- 서비스 간 API 계약
- 단계별 검증/롤백 전략
