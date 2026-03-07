# Prompt: REST API First Module

아래 API 명세를 기준으로 모듈 코드를 생성해줘.

입력
- 버전 라인: `<VERSION_LANE>`
- 모듈명: `<MODULE_NAME>`
- API 스펙: `<OPENAPI_OR_SPEC>`
- 인증 요구: `<AUTH_REQUIREMENT>`

작업 지시
1. API 계약(요청/응답/오류코드)을 먼저 확정해.
2. Controller -> Service -> Persistence 순으로 구현해.
3. 유효성 검증/예외 맵핑을 포함해.
4. OpenAPI 문서 예시를 함께 생성해.
5. API 테스트 코드와 샘플 curl을 제공해.

출력 형식
1. API 계약 요약
2. 파일 목록
3. 코드
4. 테스트/검증 명령
5. 리스크와 가정
