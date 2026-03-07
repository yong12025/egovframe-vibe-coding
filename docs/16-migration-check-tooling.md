# Migration Check Tooling

버전 라인 마이그레이션 전/중/후 정합성을 점검하는 도구 가이드입니다.

---

## 도구

- `tools/migration-lane-check.sh`

---

## 사용법

```bash
./tools/migration-lane-check.sh <PROJECT_DIR> <v4.3|v5.0-beta>
./tools/migration-lane-check.sh <PROJECT_DIR> <v4.3|v5.0-beta> /tmp/migration-check.md
```

예시

```bash
./tools/migration-lane-check.sh /Users/me/workspace/my-egov-project v5.0-beta /tmp/migration-check.md
```

---

## 점검 항목

1. 목표 라인과 Spring Boot 메이저 정합성
2. `javax.*` / `jakarta.*` import 사용량
3. 기본 조치 가이드 및 재검증 명령

---

## 결과 해석

- `PASS`: 목표 라인 기준 큰 충돌 없음
- `WARN`: 수동 확인 또는 보완 필요
- `FAIL`: 즉시 수정이 필요한 라인 충돌

---

## 연계 문서

- `docs/01-version-lane.md`
- `docs/14-troubleshooting-casebook.md`
- `prompts/review/03-migration-v43-to-v50.md`
