# Architecture Conventions

전자정부프레임워크 프로젝트의 기본 구조 규약입니다.

---

## Layer Model

- Controller: 요청/응답, 입력 검증, 에러 매핑
- Service: 비즈니스 규칙, 트랜잭션 경계
- Persistence: 데이터 접근(Mapper/Repository)

레이어 간 역방향 의존을 금지합니다.

---

## Package Convention

권장 패키지 구조

- `controller`
- `service`
- `repository` 또는 `mapper`
- `domain`
- `dto`
- `config`

---

## Naming Convention

- `<Domain>Controller`
- `<Domain>Service`, `<Domain>ServiceImpl`
- `<Domain>Mapper` 또는 `<Domain>Repository`
- `<Domain>Entity`, `<Domain>Dto`

---

## Error and Logging

- 공통 예외 포맷을 유지합니다.
- 사용자 메시지와 내부 로그 메시지를 분리합니다.
- 민감정보를 로그에 남기지 않습니다.

---

## Reference

- https://egovframe.go.kr/wiki/doku.php?id=egovframework:rtea3.9_overview
- `docs/23-convention-catalog.md`
- `docs/24-convention-recommendation-logic.md`
