# Standard Readiness Dashboard

업데이트 기준: 2026-03-07

표준 준비도 리포트를 팀이 빠르게 읽을 수 있도록 요약/배지 형태로 변환하는 운영 가이드입니다.

---

## 1) 목적

1. PASS/FAIL 상태를 한 줄로 확인
2. 추천 컨벤션/신뢰도(`selected_profile`, `confidence_score`)를 즉시 공유
3. PR/릴리스 검토 시 근거 문서를 일관 포맷으로 제출

---

## 2) 로컬 실행

먼저 준비도 리포트를 생성합니다.

```bash
./tools/standard-readiness-check.sh . /tmp/standard-readiness-report.md
```

요약/배지 파일을 생성합니다.

```bash
./tools/standard-readiness-dashboard.sh \
  /tmp/standard-readiness-report.md \
  /tmp/standard-readiness-summary.md \
  /tmp/standard-readiness-badge.json
```

생성 결과

- `/tmp/standard-readiness-summary.md`
- `/tmp/standard-readiness-badge.json`
- 공개용 기본 위치: `docs/badges/standard-readiness-badge.json`

공개용 파일 반영(선택)

```bash
cp /tmp/standard-readiness-badge.json docs/badges/standard-readiness-badge.json
```

---

## 3) CI 연계

워크플로우

- `.github/workflows/standard-readiness.yml`

CI는 아래를 아티팩트로 업로드합니다.

1. 표준 준비도 원본 리포트
2. 준비도 요약 리포트
3. 배지 JSON

---

## 4) 배지 공개 방식

저장소 URL이 확정되면 아래 템플릿으로 README에 배지를 연결합니다.

```text
https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/<OWNER>/<REPO>/main/docs/badges/standard-readiness-badge.json
```

주의

- 현재 저장소 URL이 미확정이면 placeholder 유지
- 배지 파일 경로는 팀 표준(`docs/badges/`)으로 고정 권장

---

## 5) 연계 문서

- `docs/28-standard-repo-baseline.md`
- `docs/29-standard-readiness-automation.md`
- `docs/31-standard-changelog-policy.md`
- `CHANGELOG.md`
