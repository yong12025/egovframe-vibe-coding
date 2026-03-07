# Prompt: Troubleshooting Auto Diagnosis

케이스북 기반으로 장애 원인을 자동 진단해줘.

입력
- 버전 라인: `<VERSION_LANE>`
- 증상: `<SYMPTOMS>`
- 로그/에러: `<LOGS_OR_ERRORS>`
- 최근 변경 파일: `<RECENT_CHANGED_FILES>`

작업 지시
1. `docs/14-troubleshooting-casebook.md` 케이스와 증상을 매칭해.
2. 가능한 원인을 우선순위(P1/P2/P3)로 제시해.
3. 즉시 수행할 점검 명령을 제시해.
4. 재현/검증 절차와 롤백 후보를 제시해.
5. 추가로 필요한 입력이 있으면 최대 3개 요청해.

출력 형식
1. 진단 요약
2. 원인 후보(P1/P2/P3)
3. 즉시 점검 명령
4. 수정/롤백 제안
5. 재검증 체크리스트
6. 리스크와 가정
