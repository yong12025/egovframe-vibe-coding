# Example: Batch Large Processing

대용량 배치 처리 프로젝트 예시입니다.

## Scenario

- 버전 라인: v5.0 beta
- 시작점: Batch
- 목표: 일일 집계 잡 + 실패 재처리 정책 수립

## Steps

1. `prompts/core/01-project-kickoff.md`
2. `prompts/core/02-version-lock.md`
3. `prompts/core/06-convention-profile-selection.md`
4. `prompts/generators/04-batch-job.md`
5. `prompts/review/12-convention-similarity-audit.md`
6. `prompts/review/02-security-review.md`
7. `docs/12-delivery-checklist.md`

## Deliverables

- selected_profile / confidence_score
- top_reasons / alternatives
- 잡/스텝 설계안
- 재시도/스킵/중복실행 방지 정책
- 운영/장애 대응 가이드
