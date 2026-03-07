# Convention Adoption Playbook

업데이트 기준: 2026-03-07

이 문서는 컨벤션 추천 엔진을 실제 개발 흐름에 적용하는 절차를 정의합니다.

---

## 1) 운영 정책

1. 강제 적용 없음(가이드 전용)
2. 기존 프로젝트는 유사도 우선
3. 신규 프로젝트는 `egov-fullstack-modern` 기본
4. 최종 결정은 팀 합의로 확정

---

## 2) 시나리오 A: 레거시 프로젝트에 에이전트 붙이기

### Step 1. 버전 라인 잠금

- `docs/01-version-lane.md` 기준으로 `v4.3` 또는 `v5.0-beta` 확정

### Step 2. 추천 리포트 생성

```bash
./tools/convention-recommend.sh <PROJECT_DIR> --lane <v4.3|v5.0-beta> --mode existing
```

### Step 3. 하이브리드 확인 질문 1회

- 현재 코드와 최대 유사
- 균형
- 최신 우선

응답이 없으면 `유사도 우선`을 적용합니다.

### Step 4. 작업 규칙 반영

- `docs/agent-rules.md` 산출물 형식에 `selected_profile`과 근거 추가
- 대규모 일괄 포맷 금지, 변경 파일 범위부터 적용
- `docs/26-convention-template-pack.md`에서 프로파일 템플릿 적용

---

## 3) 시나리오 B: 신규/초기 프로젝트 시작

### Step 1. auto 또는 greenfield 스캔

```bash
./tools/convention-recommend.sh <PROJECT_DIR> --lane <v5.0-beta> --mode auto
```

### Step 2. 기본 추천 확정

- 코드 자산이 부족하면 `greenfield`로 분기
- 기본값은 `egov-fullstack-modern`

### Step 3. 생성 프롬프트 연계

1. `prompts/core/06-convention-profile-selection.md`
2. `prompts/generators/*`
3. `prompts/review/12-convention-similarity-audit.md`
4. `docs/26-convention-template-pack.md`

---

## 4) 협업 체크포인트

PR/리뷰에서 아래를 확인합니다.

1. 선택한 프로파일이 명시되어 있는가
2. 추천 근거(top reasons)가 설명되는가
3. 대안(alternatives)을 검토했는가
4. migration cost가 합의되었는가

---

## 5) 권장 산출물 형식

1. 작업 요약
2. `selected_profile` / `confidence_score`
3. `top_reasons` / `alternatives`
4. `migration_cost`
5. `next_actions`
6. 검증 명령

---

## 6) 연계 문서

- `docs/23-convention-catalog.md`
- `docs/24-convention-recommendation-logic.md`
- `docs/26-convention-template-pack.md`
- `docs/27-convention-audit-report-samples.md`
- `docs/12-delivery-checklist.md`
- `CONTRIBUTING.md`
