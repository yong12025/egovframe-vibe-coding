# Prompt: Convention Similarity Audit

선택한 컨벤션 프로파일과 현재 코드의 유사도를 감사해줘.

입력
- 프로젝트 경로: `<PROJECT_DIR>`
- 버전 라인: `<VERSION_LANE>`
- 선택 프로파일: `<SELECTED_PROFILE>`

작업 지시
1. 현재 코드 시그널(Java/JS/TS/SQL, formatter/linter config)을 요약해.
2. 선택 프로파일과의 일치/불일치 항목을 표로 정리해.
3. 충돌 항목을 `즉시`, `점진`, `보류`로 분류해.
4. 기존 프로젝트 혼란 최소화를 위해 변경 우선순위를 제시해.
5. 최종 판단을 아래 계약으로 출력해.
- `selected_profile` 유지/변경 제안
- `confidence_score`
- `top_reasons` (3개)
- `alternatives` (최대 2개)
- `migration_cost`
- `next_actions`

출력 형식
1. Scan Snapshot
2. Similarity Matrix
3. Conflict Priority (즉시/점진/보류)
4. Recommendation Contract
5. 리스크와 가정
