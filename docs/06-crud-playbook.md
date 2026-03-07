# CRUD Playbook

DDL 기반으로 빠르게 CRUD를 생성할 때 사용하는 표준 절차입니다.

---

## 목표

- 반복 구현 비용 절감
- 레이어 구조 일관성 유지
- 검증 가능한 산출물 확보

---

## 표준 생성 순서

1. DDL 정의
2. Domain(VO/DTO/Entity) 생성
3. Mapper/Repository 생성
4. Service 생성
5. Controller/API 생성
6. 테스트 코드 생성

---

## 필수 규칙

- 버전 라인을 먼저 고정합니다.
- 공통컴포넌트 대체 가능 여부를 먼저 확인합니다.
- 목록 조회에는 페이징/정렬/검색 조건을 포함합니다.
- 입력 검증 및 예외 코드를 명시합니다.

---

## 권장 프롬프트

- `prompts/generators/01-crud-from-ddl.md`
- `prompts/generators/06-test-generation.md`

---

## 산출물 체크

1. 생성 파일 목록
2. 핵심 코드
3. 실행 방법
4. 검수 체크리스트

---

## 참고

- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:dev:imp:editor:codegeneration
