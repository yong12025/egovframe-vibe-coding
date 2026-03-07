# Version Lane

전자정부프레임워크 작업은 먼저 버전 라인을 고정해야 합니다.

---

## Lane A: v4.3

성격

- 안정성 우선
- 기존 레거시 프로젝트와 호환성 중심

대표 스택

- Spring Boot 2.x 계열
- Spring 5.x 계열

---

## Lane B: v5.0 beta

성격

- 최신 Boot 기반
- 신규 서비스/현대화 프로젝트 적합

대표 스택

- Spring Boot 3.x 계열
- Spring 6.x 계열

---

## 선택 기준

### v4.3 권장

- 기존 프로젝트 유지가 최우선일 때
- 보수적 릴리스 전략이 필요할 때

### v5.0 beta 권장

- 신규 구축
- 클라우드/MSA/AI 통합 요구

---

## 금지

- v4.3 코드 + v5 설정 혼합
- 한 모듈 내 다중 버전 의존성 혼합

---

## 참고

- https://www.egovframe.go.kr/home/sub.do?menuNo=12
- https://www.egovframe.go.kr/home/ntt/nttRead.do?bbsId=6&menuNo=66&nttId=1932&searchCnd=&searchCtgry=&searchKrwd=&pageIndex=1&integrDeptCode=
