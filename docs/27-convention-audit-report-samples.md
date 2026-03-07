# Convention Audit Report Samples

업데이트 기준: 2026-03-07

컨벤션 유사도 감사 리포트 샘플 5종을 제공합니다.

---

## 1) 샘플 위치

- `examples/convention-audit-reports/`

샘플 목록

1. `01-legacy-v43-java.md`
2. `02-boot3-spring-service.md`
3. `03-ts-ui-module.md`
4. `04-sql-heavy-batch.md`
5. `05-greenfield-initial.md`

---

## 2) 공통 출력 구조

모든 샘플은 아래 구조를 따릅니다.

1. Scan Snapshot
2. Similarity Matrix
3. Conflict Priority (즉시/점진/보류)
4. Recommendation Contract
5. 리스크와 가정

---

## 3) 활용 방법

1. `tools/convention-recommend.sh`로 `selected_profile`을 먼저 결정
2. 샘플 구조를 복사해 프로젝트별 감사 리포트 작성
3. PR 본문에 `Recommendation Contract`를 포함

---

## 4) 연계 문서

- `docs/24-convention-recommendation-logic.md`
- `docs/25-convention-adoption-playbook.md`
- `docs/26-convention-template-pack.md`
- `examples/convention-audit-reports/README.md`
