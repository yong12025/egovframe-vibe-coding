# Standard Repo Baseline

업데이트 기준: 2026-03-07

이 문서는 이 저장소를 "전자정부 AI 개발 표준 repo"로 운영하기 위한 최소 기준을 정의합니다.

---

## 1) 목표

1. 신규/기존 프로젝트 모두 10분 내 첫 실행 가능
2. 버전 혼합 방지와 재사용 우선 원칙 강제
3. 결과물 설명 가능성(근거/검증/리스크) 확보

---

## 2) 필수 자산

문서

- `README.md`
- `AGENTS.md`
- `CHANGELOG.md`
- `docs/agent-rules.md`
- `docs/12-delivery-checklist.md`
- `docs/23~27` (컨벤션 카탈로그/로직/플레이북/템플릿/감사샘플)
- `docs/30~31` (준비도 대시보드/변경 이력 운영 규칙)
- `docs/32` (버전 라인 분리 저장소 운영 규칙)
- `docs/33~34` (업로드 전 전체 검토 표준/리포트)
- `docs/badges/` (준비도 배지 JSON 보관)

프롬프트

- `prompts/core/06-convention-profile-selection.md`
- `prompts/review/12-convention-similarity-audit.md`
- `prompts/tool-profiles/unified-agent-instruction.md`

도구

- `tools/convention-recommend.sh`
- `tools/common-component-map-audit.sh`
- `tools/migration-lane-check.sh`
- `tools/standard-readiness-dashboard.sh`
- `tools/reference-repo-manifest-check.sh`
- `tools/pre-upload-full-review.sh`

예시

- `examples/convention-templates/`
- `examples/convention-audit-reports/`
- `references/` (lane별 분리 저장소 매니페스트)

자동화

- `.github/workflows/markdown-lint.yml`
- `.github/workflows/link-check.yml`
- `.github/workflows/standard-readiness.yml`
- `.github/workflows/reference-manifest-check.yml`
- `.github/workflows/pre-upload-review.yml`

---

## 3) 품질 게이트

1. 온보딩 게이트
- home/project 경로 기준 명령이 README에 존재
- macOS/Linux + PowerShell 병렬 안내

2. 컨벤션 게이트
- 추천 계약 필드(`selected_profile` 등)가 문서/프롬프트에 반영
- 기존=유사도 우선, 신규=`egov-fullstack-modern` 기본 정책 유지

3. 검증 게이트
- 링크/마크다운 린트 통과
- 핵심 스크립트 문법 검증 통과

4. 운영 게이트
- PR 템플릿/기여 문서에 검증 근거 제출 규칙 포함

---

## 4) 완료 정의

아래를 모두 만족하면 표준 기준 충족으로 간주합니다.

1. `tools/standard-readiness-check.sh` 결과 PASS
2. README 온보딩과 Quick Start 흐름 일치
3. 준비도 요약 리포트/배지 JSON 생성 가능
4. lane 분리 매니페스트 점검 가능(`tools/reference-repo-manifest-check.sh`)
5. 예시 워크플로우에 컨벤션 추천/감사 단계 기본 포함

---

## 5) 연계 문서

- `docs/29-standard-readiness-automation.md`
- `docs/11-github-growth-playbook.md`
- `CONTRIBUTING.md`
