# Community Contribution Playbook

Q4 P3(커뮤니티 기여 템플릿 개선) 완료 기준을 운영 관점으로 정리한 문서입니다.

---

## 1. 목표

1. 신규 기여자가 30분 내 첫 PR을 올릴 수 있게 한다.
2. 이슈-PR 품질 편차를 줄인다.
3. 리뷰 사이클을 짧게 유지한다.

---

## 2. 핵심 설계

1. 이슈 템플릿에서 버전 라인과 완료 기준을 강제한다.
2. PR 템플릿에서 검증 명령과 리스크/롤백을 강제한다.
3. `CONTRIBUTING.md`에서 빠른 기여 경로(15~30분)를 제공한다.

---

## 3. 빠른 온보딩 경로

### Step 1. 작은 작업 선택

- 문서 오탈자/링크/예시 개선
- 프롬프트 출력 형식 보강

### Step 2. 검증 명령 실행

```bash
./tools/common-component-map-audit.sh . /tmp/component-map-report.md
./tools/migration-lane-check.sh . <v4.3|v5.0-beta> /tmp/migration-check.md
```

### Step 3. 템플릿 기반 PR 제출

- 변경 요약
- 변경 파일
- 검증 결과
- 리스크/롤백

---

## 4. 리뷰 운영 기준

1. 버전 혼합 리스크가 있는지 먼저 확인
2. 문서 동선이 단순해졌는지 확인
3. 복붙 가능한 예시가 포함되었는지 확인
4. 검증 명령이 실제로 재현 가능한지 확인

---

## 5. 품질 지표(초기)

1. 첫 PR까지 걸린 시간(목표: 30분 이내)
2. PR 템플릿 미충족으로 인한 보완 요청 비율
3. 문서 변경 후 링크/린트 실패율

---

## 6. 연계 문서

- `CONTRIBUTING.md`
- `.github/ISSUE_TEMPLATE/`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `docs/11-github-growth-playbook.md`
- `docs/17-q4-priority-plan.md`
