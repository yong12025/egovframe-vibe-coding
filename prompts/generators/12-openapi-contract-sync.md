# Prompt: OpenAPI Contract Sync

기존 코드와 OpenAPI 계약을 동기화해줘.

입력
- 버전 라인: `<VERSION_LANE>`
- 대상 모듈: `<MODULE_NAME>`
- 현재 API 구현: `<API_IMPLEMENTATION>`
- 계약 문서: `<OPENAPI_SPEC>`

작업 지시
1. 구현과 계약의 불일치 항목을 식별해.
2. 계약 우선 원칙으로 수정안을 제시해.
3. 요청/응답/에러코드 스키마를 정렬해.
4. 문서 자동화 갱신 방안을 제시해.

출력 형식
1. 불일치 목록
2. 수정 파일 목록
3. 코드/문서 변경안
4. 실행/검증 명령
5. 리스크와 가정
