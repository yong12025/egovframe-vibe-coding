# Prompt Library (Auto Code Generation)

이 디렉터리는 전자정부프레임워크 실무에서 바로 쓸 수 있는 프롬프트 팩입니다.
모든 프롬프트는 버전 라인 잠금과 공통컴포넌트 재사용 원칙을 전제로 합니다.

---

## Structure

- `core/`: 프로젝트 시작/버전 잠금/컨벤션 선택/재사용 감사
- `generators/`: CRUD, 인증, 게시판, 배치, API, 테스트 생성
- `review/`: 아키텍처/보안/마이그레이션 리뷰
- `tool-profiles/`: 단일 시작 지시문(모든 모델 공통)

---

## Current Count

- `core`: 6개
- `generators`: 14개
- `review`: 12개
- `tool-profiles`: 1개
- 총 프롬프트 템플릿: 33개

---

## Usage Pattern

1. `core` 프롬프트로 버전 및 범위를 고정
2. `core/06-convention-profile-selection.md`로 컨벤션 프로파일 확정
3. `generators` 프롬프트로 코드 생성
4. `review/12-convention-similarity-audit.md`로 유사도 감사
5. `review` 프롬프트로 결함/리스크 점검
6. 결과를 `docs/12-delivery-checklist.md`로 검수

---

## Variable Convention

프롬프트 안의 아래 플레이스홀더를 교체해 사용합니다.

- `<PROJECT_NAME>`
- `<VERSION_LANE>`
- `<MODULE_NAME>`
- `<DB_TABLE>`
- `<REQUIREMENTS>`

---

## Output Contract (Recommended)

프롬프트 결과는 아래 순서를 권장합니다.

1. 작업 요약
2. selected_profile / confidence_score
3. top_reasons / alternatives
4. 파일 목록
5. 코드
6. 설정
7. 실행 방법
8. 검수 체크리스트

---

## Quality Rubric (Explainability)

프롬프트 결과는 아래 항목을 만족해야 \"설명 가능한 결과\"로 간주합니다.

1. 왜 이 결정을 했는지 근거가 있다.
2. 어떤 파일이 바뀌는지 경로 기준으로 제시한다.
3. 어떻게 검증하는지 명령/체크 항목이 있다.
4. 누락 입력에 대한 가정과 리스크를 분리해 적는다.
