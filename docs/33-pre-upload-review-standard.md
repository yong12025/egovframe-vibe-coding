# Pre-upload Review Standard

업데이트 기준: 2026-03-07

Git 업로드 전 저장소 전체를 상황별로 검토하고, eGovFrame 공식 기준 이탈 여부를 분리 보고하는 표준입니다.

---

## 1) 검토 정책

- 기준: 공식+실무확장
- 배포 게이트: 권고만 제공(차단 없음)
- 범위: 운영자/처음사용자/저장소운영자/PR기여자/CI

---

## 2) 실행 명령

```bash
./tools/pre-upload-full-review.sh . /tmp/pre-upload-review-report.md
cat /tmp/pre-upload-review-report.md
```

---

## 3) 판정 라벨

- `Official-Deviation`: 공식 기준과 충돌 또는 근거 부족
- `Repo-Policy-Gap`: 내부 규약/문서 간 불일치
- `UX-Improvement`: 사용성 개선 권고

우선순위

- High: 업로드 전 수정 권고
- Medium: 가능한 즉시 수정 권고
- Low: 후속 개선 권고

---

## 4) 보고서 섹션 계약

1. 상황별 결과
2. 공식 이탈 요약
3. 즉시 수정 권고
4. 후속 권고

---

## 5) 연계 문서

- `docs/agent-rules.md`
- `docs/28-standard-repo-baseline.md`
- `docs/29-standard-readiness-automation.md`
- `CONTRIBUTING.md`
