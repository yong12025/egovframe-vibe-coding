# Prompt: Release Readiness Gate

배포 전 준비 상태를 게이트 방식으로 점검해줘.

입력
- 버전 라인: `<VERSION_LANE>`
- 대상 릴리스: `<RELEASE_SCOPE>`
- 검증 결과: `<VALIDATION_RESULTS>`

작업 지시
1. 빌드/기능/보안/운영 항목을 Gate로 점검해.
2. 항목별 Pass/Fail와 근거를 제시해.
3. Fail 항목은 수정 순서와 롤백 기준을 제시해.
4. 최종 Go/No-Go 결론을 제시해.

출력 형식
1. Gate 점검표
2. Fail 항목 조치안
3. Go/No-Go 결론
4. 리스크와 가정
