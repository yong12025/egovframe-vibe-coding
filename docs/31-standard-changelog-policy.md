# Standard Changelog Policy

업데이트 기준: 2026-03-07

표준 repo 변경 이력을 누락 없이 관리하기 위한 운영 규칙입니다.

---

## 1) 목적

1. 변경 의도/영향/검증 근거를 추적 가능하게 유지
2. 신규 참여자가 최근 변화를 5분 안에 파악 가능하게 지원
3. 릴리스/회귀 분석 시 기준 문서로 활용

---

## 2) 대상 파일

- 루트 `CHANGELOG.md` (단일 진실 원본)

---

## 3) 분류 규칙

`CHANGELOG.md`에는 아래 헤더만 사용합니다.

- `Added`: 새 문서/도구/템플릿/워크플로우 추가
- `Changed`: 기존 동작/흐름/계약 변경
- `Fixed`: 오류 수정
- `Security`: 보안 관련 수정
- `Removed`: 제거/폐기

---

## 4) 기록 시점

아래 중 하나라도 해당하면 PR에서 changelog를 갱신합니다.

1. `docs/agent-rules.md`, `AGENTS.md`, `README.md` 계약 변경
2. `tools/*.sh` 추가/삭제/인터페이스 변경
3. `prompts/` 계약 필드 변경
4. `.github/workflows/` 품질 게이트 변경
5. 사용자 온보딩 동선에 영향이 있는 문서 변경

예외

- 오탈자만 수정한 PR은 생략 가능(리뷰어 승인 필요)

---

## 5) 릴리스 운영

1. 작업 중인 변경은 `## [Unreleased]`에 누적
2. 릴리스 시 `## [YYYY-MM-DD]` 섹션으로 고정
3. 릴리스 날짜는 반드시 절대 날짜로 기록
4. 항목은 "무엇이 바뀌었는지" 중심으로 한 줄 요약

---

## 6) PR 검수 체크

1. changelog 갱신 여부 확인
2. 표준 준비도 리포트와 changelog 내용 정합성 확인
3. 필요 시 롤백 영향 기재 여부 확인

---

## 7) 연계 문서

- `CHANGELOG.md`
- `CONTRIBUTING.md`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `docs/12-delivery-checklist.md`
