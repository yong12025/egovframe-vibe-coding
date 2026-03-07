# AGENTS.md

Repository-wide contract for all AI agents.

## Single Source of Truth

모든 모델은 동일하게 `docs/agent-rules.md`를 단일 기준으로 사용합니다.
모델별 차이는 호출 방식뿐이며, 작업 규칙 차이는 없습니다.

## Operator Safety (기존 로직 보존)

운영/레거시 프로젝트 작업 시 아래 원칙을 고정 적용합니다.

1. 요청 범위 밖의 변경 금지
2. 기존 API/DB/배치 동작 보존 우선
3. 영향도 보고 후 최소 변경 적용

## Mandatory Order

1. Lock version lane (`v4.3` or `v5.0 beta`)
2. Recommend and confirm convention profile (existing=similarity first, greenfield=`egov-fullstack-modern`)
3. Audit reusable common components
4. Generate only missing parts
5. Verify build/test/security basics
6. Return file-level deliverables
7. Run standard-readiness check and dashboard summary before release/docs handoff
8. Update `CHANGELOG.md` when contract/flow/tooling changed

## Output Format

1. Summary
2. `selected_profile` / `confidence_score`
3. `top_reasons` / `alternatives`
4. `migration_cost` / `next_actions`
5. Changed files
6. Code/config
7. Run/verify commands
8. Risks and assumptions
9. Done checklist
10. Standard readiness report/summary (when requested)
11. Changelog update note (when applicable)

## Entry Point

- `prompts/tool-profiles/unified-agent-instruction.md`
