# Contributing Guide

기여는 작고 빠르게, 검증 가능한 형태로 제출하는 것을 기본 원칙으로 합니다.

---

## 1. 기본 원칙

1. Version Lane 고정: `v4.3` 또는 `v5.0 beta`를 먼저 명시
2. Reuse First: 신규 구현 전 공통컴포넌트 재사용 가능성 확인
3. Evidence First: 변경 근거와 검증 명령을 PR에 반드시 포함

---

## 2. 가장 빠른 기여(15~30분)

문서/프롬프트 오탈자, 링크, 예시 개선은 아래 순서로 바로 기여할 수 있습니다.

1. 대상 파일 1~3개만 선택
2. 수정 이유를 한 줄로 정리
3. PR 템플릿 체크리스트를 채워 제출

권장 브랜치명

- `docs/<topic>`
- `prompts/<topic>`
- `fix/<topic>`

---

## 3. 일반 기여 절차

1. 기존 이슈 확인 또는 신규 이슈 생성
2. 작업 범위 합의(무엇을 바꾸고 무엇은 이번 PR에서 제외하는지)
3. 브랜치 생성 후 작업
4. 검증 명령 실행
5. PR 제출

---

## 4. PR 품질 게이트

PR에 아래 항목이 모두 있어야 합니다.

1. 변경 요약(무엇/왜)
2. 변경 파일 목록
3. 실행/검증 명령과 결과
4. 영향 범위와 리스크
5. 롤백 방법(필요 시)
6. `CHANGELOG.md` 반영 여부

권장 검증 명령

```bash
./tools/common-component-map-audit.sh . /tmp/component-map-report.md
./tools/migration-lane-check.sh . <v4.3|v5.0-beta> /tmp/migration-check.md
./tools/standard-readiness-check.sh . /tmp/standard-readiness-report.md
./tools/standard-readiness-dashboard.sh /tmp/standard-readiness-report.md /tmp/standard-readiness-summary.md /tmp/standard-readiness-badge.json
./tools/reference-repo-manifest-check.sh references/repos.manifest.yml /tmp/reference-repo-manifest-report.md
./tools/pre-upload-full-review.sh . /tmp/pre-upload-review-report.md
```

changelog 반영 기준

1. `README.md`/`AGENTS.md`/`docs/agent-rules.md` 계약이 바뀌면 갱신
2. `tools/*.sh` 추가/인터페이스 변경 시 갱신
3. `.github/workflows/*` 품질 게이트 변경 시 갱신
4. 단순 오탈자 수정은 리뷰어 합의 시 생략 가능

---

## 5. 문서/프롬프트 기여 기준

문서(`docs/`) 기여 기준

1. 공식 문서 기준 링크 포함
2. 복붙 가능한 명령/예시 포함
3. 버전 혼합 금지 규칙 유지

프롬프트(`prompts/`) 기여 기준

1. 입력 변수 명시(예: `<PROJECT_NAME>`)
2. 출력 형식 고정(작업 요약, 파일 목록, 코드/설정, 검증 명령, 리스크)
3. 실패 시 복구/대안 지침 포함
4. 특정 모델 전용 지시 대신 단일 에이전트 규약 유지

---

## 6. 리뷰 기준

리뷰어는 아래 순서로 확인합니다.

1. 버전 라인 충돌 위험
2. 재사용 누락 여부
3. 검증 결과 신뢰성
4. 문서 탐색 동선 단순성

---

## 7. 커뮤니티 규정

- 행동 기준: `CODE_OF_CONDUCT.md`
- 보안 제보: `SECURITY.md`
- 로드맵: `ROADMAP.md`

---

## 8. Reference

- https://github.com/eGovFramework/egovframe-docs
- https://www.egovframe.go.kr
