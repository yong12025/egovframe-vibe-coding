# eGovFrame Vibe Coding Guide

![Version Lane](https://img.shields.io/badge/version%20lane-v4.3%20%7C%20v5.0--beta-0A7E3B?logo=spring)
![Unified Agent](https://img.shields.io/badge/agent-unified-2563EB?logo=githubcopilot)
![Convention](https://img.shields.io/badge/convention-recommendation-7C3AED?logo=eslint)
![Readiness](https://img.shields.io/badge/readiness-report%20%26%20dashboard-F59E0B?logo=githubactions)

전자정부프레임워크 프로젝트를 AI Agent 중심으로 빠르게 설계, 생성, 검증하기 위한 실행형 플레이북입니다.
설명보다 실행을 우선하며, 대부분의 섹션은 그대로 복붙해서 사용할 수 있게 구성했습니다.

> 목표: 버전 혼합 없이, 공통컴포넌트 재사용을 우선하고, 검증 가능한 산출물을 빠르게 만드는 것

- 공식 포털: https://www.egovframe.go.kr/home/main.do
- 기준 원칙: 이 저장소는 공식 문서를 대체하지 않음

## 🧭 빠른 이동

- [🚀 온보딩 실행](#온보딩-실행-home프로젝트-경로-기준)
- [👶 처음 사용자용](#beginner-flow)
- [🛡 운영자용](#operator-flow)
- [🧩 단일 규약](#단일-규약-모든-도구-공통)
- [📤 10분 산출물](#10분-내-기대-산출물)
- [📚 문서 읽기 순서](#추천-읽기-순서)
- [🤝 기여/성장 가이드](#github-운영성장)

---

## 🎯 왜 필요한가

현업에서 반복되는 아래 문제를 줄이기 위해 만들었습니다.

- 버전 혼합으로 인한 빌드/런타임 오류
- 공통컴포넌트 재사용 누락으로 인한 중복 개발
- CRUD 반복 구현으로 인한 생산성 저하
- AI 코드 생성 결과물의 품질 편차
- 문서/코드/검수 산출물 형식 불일치

---

## ✨ 이 저장소로 얻는 것

- 강력한 에이전트 규약: `docs/agent-rules.md`
- 최신 컨벤션 카탈로그: `docs/23-convention-catalog.md`
- 컨벤션 템플릿 팩: `docs/26-convention-template-pack.md`
- 컨벤션 감사 샘플 5종: `docs/27-convention-audit-report-samples.md`
- 표준 repo 기준선: `docs/28-standard-repo-baseline.md`
- 표준 준비도 대시보드: `docs/30-standard-readiness-dashboard.md`
- 표준 변경 이력 정책: `docs/31-standard-changelog-policy.md`
- lane 분리 저장소 운영 규칙: `docs/32-reference-repo-split-operations.md`
- 자동 코드 생성 프롬프트 팩: `prompts/`
- 단일 시작 지시문: `prompts/tool-profiles/unified-agent-instruction.md`
- 실전 문서 플레이북: `docs/`
- 운영 자동화 도구: `tools/`
- GitHub 협업 템플릿: `.github/`

---

## 🧰 시작 전 준비

1. Git 설치
2. AI 코딩 도구 1개 이상(Codex/Cursor/Claude 등)
3. PowerShell 사용 시 `bash` 실행 환경(WSL 또는 Git Bash) 권장
4. 프로젝트 버전 라인(v4.3 또는 v5.0 beta) 결정

주의

- 이 문서의 `<GUIDE_REPO_URL>`은 placeholder입니다.
- 실제 업로드/사용 전 자신의 저장소 URL로 반드시 교체합니다.
- 교체 위치: 온보딩 Step 0의 `GUIDE_REPO_URL` 선언부

---

## 온보딩 실행 (home/프로젝트 경로 기준)

아래에서 본인 상황에 맞는 흐름 하나를 선택해 시작합니다.

<a id="operator-flow"></a>

### A) 운영자용: 기존 프로젝트에 에이전트 붙이기 (기존 로직 보존 우선)

운영자 안전 원칙

- 요청 범위 밖의 로직/동작은 변경하지 않음
- 기존 API 계약, DB 스키마, 배치 동작은 요청 없으면 유지
- 먼저 리포트(분석/영향도) 작성 후 최소 변경 적용
- 변경 시 파일 단위 근거와 검증 명령을 반드시 함께 제공

Step 0. 가이드 저장소 URL 1회 선언

macOS/Linux

```bash
GUIDE_REPO_URL=<GUIDE_REPO_URL>
# 예시 HTTPS: GUIDE_REPO_URL=https://github.com/yong12025/egovframe-vibe-coding.git
# 예시 SSH: GUIDE_REPO_URL=git@github.com:yong12025/egovframe-vibe-coding.git
```

Windows PowerShell

```powershell
$GUIDE_REPO_URL = "<GUIDE_REPO_URL>"
# 예시 HTTPS: $GUIDE_REPO_URL = "https://github.com/yong12025/egovframe-vibe-coding.git"
# 예시 SSH: $GUIDE_REPO_URL = "git@github.com:yong12025/egovframe-vibe-coding.git"
```

Step 1. home 경로로 이동 후 가이드 저장소 클론

macOS/Linux

```bash
cd ~
git clone "$GUIDE_REPO_URL"
```

Windows PowerShell

```powershell
Set-Location $HOME
git clone $GUIDE_REPO_URL
```

Step 2. 가이드/대상 프로젝트 경로 변수 선언

macOS/Linux

```bash
GUIDE_DIR=~/egovframe-vibe-coding
TARGET_PROJECT_DIR=~/workspace/my-egov-project
cd "$GUIDE_DIR"
```

Windows PowerShell

```powershell
$GUIDE_DIR = Join-Path $HOME "egovframe-vibe-coding"
$TARGET_PROJECT_DIR = "C:\\workspace\\my-egov-project"
Set-Location $GUIDE_DIR
```

Step 3. 컨벤션 추천 리포트 생성

macOS/Linux

```bash
./tools/convention-recommend.sh "$TARGET_PROJECT_DIR" --lane v5.0-beta --mode auto --output /tmp/convention-recommend-report.md
cat /tmp/convention-recommend-report.md
```

Windows PowerShell

```powershell
bash ./tools/convention-recommend.sh "$TARGET_PROJECT_DIR" --lane v5.0-beta --mode auto --output /tmp/convention-recommend-report.md
Get-Content /tmp/convention-recommend-report.md
```

Step 4. 단일 지시문으로 에이전트 실행

- 엔트리포인트: `prompts/tool-profiles/unified-agent-instruction.md`
- 규약 기준: `docs/agent-rules.md`

Step 5. 산출물 계약 확인

- `selected_profile`
- `confidence_score`
- `top_reasons`
- `alternatives`
- `migration_cost`
- `next_actions`
- 변경 파일 목록
- 실행/검증 명령

Step 6. 표준 준비도 체크(권장)

macOS/Linux

```bash
./tools/standard-readiness-check.sh "$GUIDE_DIR" /tmp/standard-readiness-report.md
cat /tmp/standard-readiness-report.md
```

Windows PowerShell

```powershell
bash ./tools/standard-readiness-check.sh "$GUIDE_DIR" /tmp/standard-readiness-report.md
Get-Content /tmp/standard-readiness-report.md
```

Step 7. 준비도 요약/배지 생성(권장)

macOS/Linux

```bash
./tools/standard-readiness-dashboard.sh /tmp/standard-readiness-report.md /tmp/standard-readiness-summary.md /tmp/standard-readiness-badge.json
cat /tmp/standard-readiness-summary.md
```

Windows PowerShell

```powershell
bash ./tools/standard-readiness-dashboard.sh /tmp/standard-readiness-report.md /tmp/standard-readiness-summary.md /tmp/standard-readiness-badge.json
Get-Content /tmp/standard-readiness-summary.md
```

Step 8. lane 분리 매니페스트 점검(운영자 권장)

macOS/Linux

```bash
./tools/reference-repo-manifest-check.sh references/repos.manifest.yml /tmp/reference-repo-manifest-report.md
cat /tmp/reference-repo-manifest-report.md
```

Windows PowerShell

```powershell
bash ./tools/reference-repo-manifest-check.sh references/repos.manifest.yml /tmp/reference-repo-manifest-report.md
Get-Content /tmp/reference-repo-manifest-report.md
```

<a id="beginner-flow"></a>

### B) 처음 사용자용: 신규 프로젝트 시작하기

Step 0. (A를 먼저 실행하지 않았다면) 가이드 저장소 URL 1회 선언

macOS/Linux

```bash
GUIDE_REPO_URL=<GUIDE_REPO_URL>
# 예시 HTTPS: GUIDE_REPO_URL=https://github.com/yong12025/egovframe-vibe-coding.git
# 예시 SSH: GUIDE_REPO_URL=git@github.com:yong12025/egovframe-vibe-coding.git
```

Windows PowerShell

```powershell
$GUIDE_REPO_URL = "<GUIDE_REPO_URL>"
# 예시 HTTPS: $GUIDE_REPO_URL = "https://github.com/yong12025/egovframe-vibe-coding.git"
# 예시 SSH: $GUIDE_REPO_URL = "git@github.com:yong12025/egovframe-vibe-coding.git"
```

Step 1. home 경로로 이동 후 가이드 저장소 클론

macOS/Linux

```bash
cd ~
git clone "$GUIDE_REPO_URL"
```

Windows PowerShell

```powershell
Set-Location $HOME
git clone $GUIDE_REPO_URL
```

Step 2. 가이드/신규 프로젝트 경로 선언

macOS/Linux

```bash
GUIDE_DIR=~/egovframe-vibe-coding
TARGET_PROJECT_DIR=~/workspace/new-egov-service
mkdir -p "$TARGET_PROJECT_DIR"
cd "$GUIDE_DIR"
```

Windows PowerShell

```powershell
$GUIDE_DIR = Join-Path $HOME "egovframe-vibe-coding"
$TARGET_PROJECT_DIR = "C:\\workspace\\new-egov-service"
New-Item -ItemType Directory -Force -Path $TARGET_PROJECT_DIR | Out-Null
Set-Location $GUIDE_DIR
```

Step 3. greenfield 기준 추천 리포트 생성

macOS/Linux

```bash
./tools/convention-recommend.sh "$TARGET_PROJECT_DIR" --lane v5.0-beta --mode greenfield --output /tmp/convention-recommend-report.md
cat /tmp/convention-recommend-report.md
```

Windows PowerShell

```powershell
bash ./tools/convention-recommend.sh "$TARGET_PROJECT_DIR" --lane v5.0-beta --mode greenfield --output /tmp/convention-recommend-report.md
Get-Content /tmp/convention-recommend-report.md
```

Step 4. 템플릿/프롬프트 순서 적용

1. `docs/26-convention-template-pack.md`
2. `prompts/core/06-convention-profile-selection.md`
3. `prompts/generators/*`
4. `prompts/review/12-convention-similarity-audit.md`

### C) 공통: 경로 실수 방지 체크

실행 전에 아래 3가지를 확인합니다.

macOS/Linux

```bash
pwd
ls -la "$GUIDE_DIR"
ls -la "$TARGET_PROJECT_DIR"
```

Windows PowerShell

```powershell
Get-Location
Get-ChildItem $GUIDE_DIR
Get-ChildItem $TARGET_PROJECT_DIR
```

---

## 단일 규약 (모든 도구 공통)

모델/도구별 절차를 분기하지 않고 아래 경로만 사용합니다.

1. `docs/agent-rules.md`
2. `prompts/tool-profiles/unified-agent-instruction.md`
3. `docs/12-delivery-checklist.md`
4. `docs/28-standard-repo-baseline.md`
5. `docs/31-standard-changelog-policy.md`

---

## 10분 내 기대 산출물

1. 버전 잠금 결과
2. `selected_profile` / `confidence_score`
3. `top_reasons` / `alternatives`
4. `migration_cost` / `next_actions`
5. 변경 파일 목록
6. 코드/설정
7. 실행/검증 명령
8. 리스크와 가정
9. 완료 체크리스트
10. 표준 준비도 요약(`status`, `missing_count`)
11. `CHANGELOG.md` 갱신 여부

샘플 결과물

- `examples/new-boot-service/DELIVERY_SAMPLE.md`
- `examples/convention-audit-reports/README.md`
- `examples/legacy-modernization/README.md`

---

## 업로드 전 전체 검토

상황별(운영자/처음사용자/저장소운영자/PR기여자/CI) 검토와 공식 이탈 라벨 보고를 한 번에 수행합니다.

```bash
./tools/pre-upload-full-review.sh . /tmp/pre-upload-review-report.md
cat /tmp/pre-upload-review-report.md
```

검토 표준/샘플 리포트

- `docs/33-pre-upload-review-standard.md`
- `docs/34-pre-upload-review-report-2026-03-07.md`

---

## Repository Architecture

```
egovframe-vibe-coding/
├─ README.md
├─ AGENTS.md
├─ CONTRIBUTING.md
├─ CODE_OF_CONDUCT.md
├─ SECURITY.md
├─ LICENSE
├─ docs/
│  ├─ agent-rules.md
│  └─ ...
├─ prompts/
├─ examples/
├─ references/
├─ .cursor/rules/
└─ .github/
```

상세 구조 설명: `docs/10-repository-architecture.md`

---

## AI Tooling

단일 규약

- `docs/agent-rules.md`
- `prompts/tool-profiles/unified-agent-instruction.md`

호환용 환경 파일(선택)

- `AGENTS.md`
- `.cursor/rules/egovframe.mdc`

---

## Prompt Packs

- 코어: `prompts/core/`
- 코드 생성: `prompts/generators/`
- 리뷰/진단: `prompts/review/`
- 도구별 실행 템플릿: `prompts/tool-profiles/`

프롬프트 인덱스: `docs/09-prompt-library.md`

---

## 추천 읽기 순서

### 신규 프로젝트

1. `docs/01-version-lane.md`
2. `docs/23-convention-catalog.md`
3. `docs/02-template-selector.md`
4. `docs/03-quick-start.md`
5. `docs/agent-rules.md`
6. `prompts/core/06-convention-profile-selection.md`
7. `prompts/generators/01-crud-from-ddl.md`

### 레거시 현대화

1. `docs/01-version-lane.md`
2. `docs/04-architecture-conventions.md`
3. `docs/24-convention-recommendation-logic.md`
4. `docs/05-common-components-map.md`
5. `prompts/review/03-migration-v43-to-v50.md`
6. `prompts/review/12-convention-similarity-audit.md`
7. `docs/07-troubleshooting.md`

---

## GitHub 운영/성장

- 이슈/PR 템플릿 제공: `.github/ISSUE_TEMPLATE`, `.github/PULL_REQUEST_TEMPLATE.md`
- 기여 문서 표준화: `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`
- 변경 이력 투명성: `CHANGELOG.md`
- 공개 로드맵 운영: `ROADMAP.md`
- 실행 예시 제공: `examples/`
- 버전 라인 분리 매니페스트: `references/repos.manifest.yml`
- 기여 온보딩 플레이북: `docs/22-community-contribution-playbook.md`
- 준비도 배지 endpoint는 저장소 URL 확정 후 연결: `docs/30-standard-readiness-dashboard.md`

실행 전략 가이드: `docs/11-github-growth-playbook.md`

---

## Official References

- https://www.egovframe.go.kr
- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:dev4.3:gettingstarted
- https://github.com/eGovFramework/egovframe-docs

---

## Notice

이 저장소는 공식 문서를 대체하지 않습니다. 최종 기준은 항상 공식 문서입니다.
