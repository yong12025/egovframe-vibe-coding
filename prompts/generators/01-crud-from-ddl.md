# Prompt: CRUD From DDL

아래 DDL 기준으로 전자정부프레임워크 CRUD를 생성해줘.

입력
- 버전 라인: `<VERSION_LANE>`
- 모듈명: `<MODULE_NAME>`
- DDL: `<DDL_SQL>`
- API 스타일: `<API_STYLE>` (MVC/REST)

작업 지시
1. DDL에서 엔티티/VO/DTO를 설계해.
2. Mapper(또는 Repository)와 SQL 매핑을 생성해.
3. Service 인터페이스와 구현체를 생성해.
4. Controller와 요청/응답 모델을 작성해.
5. 목록조회 페이징/정렬/검색 조건을 포함해.
6. 예외 처리와 검증 코드를 추가해.
7. 최소 테스트 코드를 생성해.

출력 형식
1. 작업 요약
2. 생성 파일 목록
3. 코드
4. 설정
5. 실행 방법
6. 검수 체크리스트
7. 리스크와 가정

추가 제약
- 버전 혼합 금지
- 공통컴포넌트로 대체 가능한 부분은 먼저 제안
