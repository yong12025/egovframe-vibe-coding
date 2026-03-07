# Quick Start

처음 사용자 기준으로 `home(~)` 또는 기존 프로젝트 경로에서 바로 시작하는 실행 순서입니다.

---

## 1) 준비

1. Git 설치
2. AI 코딩 도구 준비
3. PowerShell 사용 시 `bash` 실행 환경(WSL/Git Bash) 준비
4. 버전 라인(`v4.3` 또는 `v5.0 beta`) 결정

주의

- `<GUIDE_REPO_URL>`은 placeholder입니다.
- 실제 사용 전 자신의 저장소 URL로 교체합니다.

---

## 2) 기존 프로젝트에 에이전트 붙이기

Step 0. 가이드 저장소 URL 1회 선언

macOS/Linux

```bash
GUIDE_REPO_URL=<GUIDE_REPO_URL>
# 예시 HTTPS: GUIDE_REPO_URL=https://github.com/your-org/egovframe-vibe-coding.git
# 예시 SSH: GUIDE_REPO_URL=git@github.com:your-org/egovframe-vibe-coding.git
```

Windows PowerShell

```powershell
$GUIDE_REPO_URL = "<GUIDE_REPO_URL>"
# 예시 HTTPS: $GUIDE_REPO_URL = "https://github.com/your-org/egovframe-vibe-coding.git"
# 예시 SSH: $GUIDE_REPO_URL = "git@github.com:your-org/egovframe-vibe-coding.git"
```

Step 1. 가이드 저장소 클론

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

Step 2. 경로 변수 선언

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

---

## 3) 신규 프로젝트 시작

Step 0. (2번 흐름을 먼저 실행하지 않았다면) 가이드 저장소 URL 1회 선언

macOS/Linux

```bash
GUIDE_REPO_URL=<GUIDE_REPO_URL>
# 예시 HTTPS: GUIDE_REPO_URL=https://github.com/your-org/egovframe-vibe-coding.git
# 예시 SSH: GUIDE_REPO_URL=git@github.com:your-org/egovframe-vibe-coding.git
```

Windows PowerShell

```powershell
$GUIDE_REPO_URL = "<GUIDE_REPO_URL>"
# 예시 HTTPS: $GUIDE_REPO_URL = "https://github.com/your-org/egovframe-vibe-coding.git"
# 예시 SSH: $GUIDE_REPO_URL = "git@github.com:your-org/egovframe-vibe-coding.git"
```

Step 1. 경로 변수 선언과 디렉터리 생성

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

Step 2. greenfield 리포트 생성

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

---

## 4) 경로 실수 방지 체크

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

## 5) 단일 규약으로 에이전트 실행

1. `docs/agent-rules.md`
2. `prompts/tool-profiles/unified-agent-instruction.md`
3. `docs/12-delivery-checklist.md`
4. `docs/28-standard-repo-baseline.md`
5. `docs/31-standard-changelog-policy.md`

---

## 6) 표준 준비도 점검

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

---

## 7) 준비도 요약/배지 생성

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

---

## 8) lane 분리 매니페스트 점검(운영자 권장)

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

---

## 9) 업로드 전 전체 검토(권장)

macOS/Linux

```bash
./tools/pre-upload-full-review.sh . /tmp/pre-upload-review-report.md
cat /tmp/pre-upload-review-report.md
```

Windows PowerShell

```powershell
bash ./tools/pre-upload-full-review.sh . /tmp/pre-upload-review-report.md
Get-Content /tmp/pre-upload-review-report.md
```

---

## 10) 산출물 계약 확인

아래 항목이 나오면 정상 시작입니다.

1. `selected_profile`
2. `confidence_score`
3. `top_reasons`
4. `alternatives`
5. `migration_cost`
6. `next_actions`
7. 변경 파일 목록
8. 실행/검증 명령
9. 표준 준비도 요약(`status`, `missing_count`)

---

## 공식 가이드

- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:dev4.3:gettingstarted
