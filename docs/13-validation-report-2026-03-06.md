# Validation Report (2026-03-06)

본 문서는 2026-03-06 기준으로 프롬프트 설명가능성/재현성 및 외부 링크 접속성을 점검한 결과입니다.

---

## 1) Prompt Quality Audit

검증 기준

- 입력/작업 지시/출력 형식 존재
- 버전 라인 명시
- 리스크/가정 명시
- 검증 절차 또는 검증 명령 포함

결과 요약

- `prompts/core`, `prompts/generators`, `prompts/review` 전 파일에 입력/작업 지시/출력 형식 존재
- 전 파일에 버전 라인 관련 제약 존재
- 리스크/가정 항목을 공통적으로 포함하도록 보강 완료
- 리뷰 프롬프트에 파일 경로/라인 번호 근거 요구 보강 완료

대표 드라이런 대상

- `prompts/generators/01-crud-from-ddl.md`: 통과
- `prompts/generators/02-login-rbac.md`: 통과
- `prompts/review/01-architecture-review.md`: 통과

---

## 2) Link Verification (Official Sources)

확인 날짜: 2026-03-06

### Directly reachable

- https://www.egovframe.go.kr/home/main.do
- https://www.egovframe.go.kr/home/sub.do?menuNo=12
- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:dev4.3:gettingstarted
- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:com:v4.3:init_guide
- https://www.egovframe.go.kr/home/sub.do?menuNo=68
- https://github.com/eGovFramework/egovframe-docs
- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:dev:imp:editor:codegeneration

### Reachable via navigation/search fallback

- https://www.egovframe.go.kr/home/ntt/nttRead.do?bbsId=6&menuNo=66&nttId=1932
  - 안정 접속 URL 사용: `bbsId=6&menuNo=66&nttId=1932...`

---

## 3) Applied Improvements

- `docs/agent-rules.md` 경로 기준으로 참조 일원화
- 주요 생성/리뷰 프롬프트 출력 형식에 아래 항목 강화
  - 실행/검증 명령
  - 리스크와 가정
  - 근거 기반 리뷰(파일/라인)
- `docs/01-version-lane.md`, `docs/08-modern-stack.md` 공지 링크를 안정 URL로 교체
- `docs/02-template-selector.md`에서 불안정한 딥링크 제거 후 검증된 공식 링크로 정리

---

## 4) Remaining Risk

- 일부 위키 딥링크는 접속 환경에 따라 불안정할 수 있음
- 향후 공식 문서 구조 변경 시 링크 재검증 필요
