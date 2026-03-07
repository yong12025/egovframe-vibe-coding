# Prompt: Convention Profile Selection

현재 프로젝트에 맞는 코드 컨벤션 프로파일을 추천/확정해줘.

입력
- 프로젝트 경로: `<PROJECT_DIR>`
- 버전 라인: `<VERSION_LANE>` (`v4.3` 또는 `v5.0-beta`)
- 모드: `<MODE>` (`auto|existing|greenfield`)

작업 지시
1. `tools/convention-recommend.sh` 인터페이스 기준으로 비파괴 스캔 결과를 요약해.
2. 아래 출력 계약을 반드시 채워.
- `selected_profile`
- `confidence_score`
- `top_reasons` (3개)
- `alternatives` (최대 2개)
- `migration_cost` (low|medium|high)
- `next_actions`
3. 하이브리드 확인 질문을 1회 제시해.
- `현재 코드와 최대 유사 / 균형 / 최신 우선`
4. 응답이 없을 때 기본값을 적용해.
- existing: 유사도 우선
- greenfield: `egov-fullstack-modern`

출력 형식
1. Recommendation Contract
2. Hybrid Question
3. Default Decision
4. 적용 시 주의사항
