# Changelog

이 문서는 표준 repo 운영 관점에서 의미 있는 변경 이력을 기록합니다.
포맷은 Keep a Changelog 구조를 따르며, 날짜는 `YYYY-MM-DD`(절대 날짜)로 기록합니다.

## [Unreleased]

### Added

- 표준 준비도 대시보드 스크립트(`tools/standard-readiness-dashboard.sh`) 추가
- 표준 준비도 대시보드 운영 문서(`docs/30-standard-readiness-dashboard.md`) 추가
- 변경 이력 운영 정책 문서(`docs/31-standard-changelog-policy.md`) 추가
- 레퍼런스 분리 운영 문서(`docs/32-reference-repo-split-operations.md`) 추가
- lane 저장소 매니페스트/메타 디렉터리(`references/`) 추가
- 매니페스트 검증 스크립트/CI(`tools/reference-repo-manifest-check.sh`, `.github/workflows/reference-manifest-check.yml`) 추가
- 업로드 전 전체 검토 스크립트(`tools/pre-upload-full-review.sh`) 추가
- 업로드 전 전체 검토 표준/리포트(`docs/33`, `docs/34`) 추가
- 업로드 전 전체 검토 CI(`.github/workflows/pre-upload-review.yml`) 추가

### Changed

- README/Quick Start/AGENTS/CONTRIBUTING에 표준 준비도 요약 및 changelog 계약 반영
- 표준 준비도 CI에서 요약 리포트/배지 JSON 아티팩트 업로드로 확장
- 표준 준비도 기준선에 lane 분리 운영 자산(`docs/32`, `references/`, manifest check workflow) 반영
- CONTRIBUTING/PR 템플릿 검증 명령에 pre-upload full review 추가
- 운영자 보존 원칙을 README/AGENTS/agent-rules/unified instruction에 정렬
- `nttId=1932` 공지 링크를 안정 URL(`menuNo=66`) 기준으로 정리
- README/Quick Start의 clone URL placeholder를 `<GUIDE_REPO_URL>` 패턴으로 통일
- Quick Start에 업로드 전 전체 검토 단계(`tools/pre-upload-full-review.sh`) 추가
- README 온보딩 명령을 TARGET_PROJECT_DIR 부모(형제 경로) 기준으로 정렬하고, 가이드 저장소는 미존재 시에만 clone 하도록 수정
- README PowerShell 온보딩 예시에서 TARGET_PARENT_DIR를 현재 위치 기준으로 계산하도록 수정해 null 경로 오류를 방지
- README Windows 예시에서 bash 출력 파일을 PowerShell 경로가 아닌 bash 컨텍스트에서 읽도록 수정하고, bookPod 기준 현재 위치 흐름으로 정렬
- README PowerShell 예시에 bash 전달용 경로(`C:/...`) 변환을 추가해 bookPod 기준 복붙 실행이 가능하도록 수정
- README에 버전 레인 의미 설명과 에이전트 요청 예시를 추가해 초보 사용자 온보딩을 보강

## [2026-03-07]

### Added

- 컨벤션 추천 엔진 v1(`docs/23~25`, `tools/convention-recommend.sh`)
- 컨벤션 템플릿/감사 샘플(`docs/26~27`, `examples/convention-*`)
- 표준 repo 기준선/준비도 점검(`docs/28~29`, `tools/standard-readiness-check.sh`)

### Changed

- 온보딩을 home/project 경로 기준 복붙 실행형으로 개편
- 단일 규약(unified agent) 기준으로 문서 동선 정렬
