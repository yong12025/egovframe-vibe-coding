# Repository Architecture

이 문서는 저장소를 실제 팀이 장기 운영할 수 있도록 구조화한 기준입니다.

---

## Top-Level Map

- `docs/agent-rules.md`: 코어 운영 규약
- `prompts/tool-profiles/unified-agent-instruction.md`: 모든 모델 공통 시작 지시문
- `AGENTS.md`, `.cursor/rules/`: 호환용 진입 파일
- `prompts/`: 자동 생성 프롬프트 라이브러리
- `docs/`: 플레이북 및 가이드
- `.github/`: 협업 템플릿/자동화
- `tools/`: 운영 자동화 스크립트
- `examples/`: 실전 시나리오 예시
- `references/`: 버전 라인 분리 저장소 매니페스트/메타정보
- `docs/28~29`: 표준 repo 기준선/자동 점검
- `docs/30~32`: 준비도 대시보드/변경이력/분리운영 규칙

---

## Information Architecture

문서는 세 층으로 나눕니다.

1. Onboarding Layer
- README
- docs/01~03

2. Build Layer
- docs/agent-rules.md
- docs/04~08
- prompts/generators

3. Quality Layer
- prompts/review
- docs/12-delivery-checklist
- SECURITY/CODE_OF_CONDUCT/CONTRIBUTING

---

## Prompt-Driven Delivery

기능 개발은 아래 루프를 따릅니다.

1. `core` 프롬프트로 범위 잠금
2. `generators` 프롬프트로 코드 생성
3. `review` 프롬프트로 결함 점검
4. 체크리스트로 완료 판정
5. 표준 준비도 스크립트로 릴리스 전 점검

---

## Design Rules

- 문서와 코드 산출물은 파일 단위로 추적 가능해야 함
- 버전 라인과 템플릿 타입을 항상 먼저 선언
- 공통컴포넌트 재사용 근거를 남김
- 모든 작업은 검증 가능한 명령을 포함
