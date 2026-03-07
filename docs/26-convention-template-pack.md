# Convention Template Pack

업데이트 기준: 2026-03-07

컨벤션 추천 결과를 바로 적용할 수 있도록 프로파일별 샘플 설정 템플릿을 제공합니다.

---

## 1) 위치

- `examples/convention-templates/`

포함 프로파일

1. `egov-legacy-safe`
2. `egov-java-google`
3. `egov-java-spring`
4. `egov-ts-prettier-eslint`
5. `egov-sql-standard`
6. `egov-fullstack-modern`

---

## 2) 파일 맵

- `egov-legacy-safe/checkstyle-relaxed.xml`
- `egov-java-google/checkstyle-google.xml`
- `egov-java-google/spotless.gradle.snippet`
- `egov-java-spring/.springjavaformatconfig`
- `egov-java-spring/spotless-spring.gradle.snippet`
- `egov-ts-prettier-eslint/eslint.config.mjs`
- `egov-ts-prettier-eslint/.prettierrc.json`
- `egov-sql-standard/.sqlfluff`
- `egov-fullstack-modern/README.md`

---

## 3) 적용 절차

1. 추천 리포트 생성

```bash
./tools/convention-recommend.sh <PROJECT_DIR> --lane <v4.3|v5.0-beta> --mode auto
```

2. `selected_profile` 확인
3. 해당 템플릿 파일을 프로젝트로 복사
4. 신규/변경 파일부터 점진 적용
5. `prompts/review/12-convention-similarity-audit.md`로 적합성 재검증

---

## 4) 주의사항

1. 가이드 전용 정책이므로 CI 실패 강제는 하지 않습니다.
2. 기존 프로젝트는 대규모 일괄 포맷을 금지합니다.
3. 포맷/린트와 기능 변경은 PR을 분리합니다.

---

## 5) 연계 문서

- `docs/23-convention-catalog.md`
- `docs/24-convention-recommendation-logic.md`
- `docs/25-convention-adoption-playbook.md`
- `docs/27-convention-audit-report-samples.md`
- `examples/convention-templates/README.md`
