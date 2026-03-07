# Standard Readiness Automation

업데이트 기준: 2026-03-07

표준 repo 기준 충족 여부를 자동으로 점검하는 방법입니다.

---

## 1) 로컬 점검

```bash
./tools/standard-readiness-check.sh . /tmp/standard-readiness-report.md
cat /tmp/standard-readiness-report.md
./tools/standard-readiness-dashboard.sh /tmp/standard-readiness-report.md /tmp/standard-readiness-summary.md /tmp/standard-readiness-badge.json
cat /tmp/standard-readiness-summary.md
```

점검 항목

1. 필수 문서/프롬프트/도구/예시 존재
2. 컨벤션 추천 스크립트 스모크 테스트
3. 핵심 계약 필드 반영 여부
4. 요약 리포트/배지 JSON 생성
5. lane 분리 매니페스트 자산/워크플로우 존재

---

## 2) CI 점검

워크플로우

- `.github/workflows/standard-readiness.yml`
- `.github/workflows/reference-manifest-check.yml`
- `.github/workflows/pre-upload-review.yml`

CI에서 수행하는 항목

1. 셸 스크립트 문법 검사
2. 표준 준비도 점검 스크립트 실행
3. 준비도 요약/배지 생성
4. 리포트 아티팩트 업로드
5. lane 분리 매니페스트 정합성 검증(별도 워크플로우)
6. 업로드 전 상황별 전체 검토 리포트 생성(별도 워크플로우)

배지 기본 경로

- `docs/badges/standard-readiness-badge.json`

---

## 3) 운영 원칙

1. 표준 준비도 점검은 구조/운영 품질 확인 목적
2. 코드 컨벤션 강제 실패는 기본 정책에서 제외(가이드 전용)
3. 실패 시 누락 자산을 보완하고 재실행

---

## 4) 연계 문서

- `docs/28-standard-repo-baseline.md`
- `docs/30-standard-readiness-dashboard.md`
- `tools/README.md`
- `README.md`
