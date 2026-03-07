# Reference Repo Split Operations

업데이트 기준: 2026-03-07

버전 라인별 레퍼런스 구현 샘플 저장소를 분리 운영하기 위한 표준 절차입니다.

---

## 1) 목적

1. v4.3 / v5.0 beta 샘플의 의존성 충돌을 원천 차단
2. lane별 샘플 릴리스 주기 분리
3. 신규 기여자가 lane별 목표를 명확히 이해하도록 지원

---

## 2) 단일 매니페스트 운영

분리 저장소의 단일 원본

- `references/repos.manifest.yml`

매니페스트 검증

```bash
./tools/reference-repo-manifest-check.sh references/repos.manifest.yml /tmp/reference-repo-manifest-report.md
cat /tmp/reference-repo-manifest-report.md
```

---

## 3) lane 운영 규칙

v4.3

- 기본 컨벤션: `egov-legacy-safe`
- 목적: 안정 유지, 레거시 현대화

v5.0 beta

- 기본 컨벤션: `egov-fullstack-modern`
- 목적: 신규 개발, Boot/AI/MSA 확장

---

## 4) 전환 단계

1. `planned`: URL placeholder 상태
2. `active`: 공개 저장소 생성 및 README 연결 완료
3. `stable`: 정기 릴리스/기여 정책 정착

---

## 5) CI 연계

워크플로우

- `.github/workflows/reference-manifest-check.yml`

검증 항목

1. lane(v4.3/v5.0-beta) 존재
2. repo_name/repo_url/convention_profile/scenarios 존재
3. placeholder 사용 여부 경고 출력

---

## 6) 연계 문서

- `references/README.md`
- `docs/18-reference-architecture.md`
- `docs/28-standard-repo-baseline.md`
- `ROADMAP.md`
