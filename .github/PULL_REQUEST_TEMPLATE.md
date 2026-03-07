## 1) Summary

무엇을 왜 변경했는지 3~5줄로 작성해 주세요.

## 2) Change Type

- [ ] docs
- [ ] prompts
- [ ] agent-rules
- [ ] examples
- [ ] tools
- [ ] fix

## 3) Version Lane

- [ ] v4.3
- [ ] v5.0 beta
- [ ] not-applicable (docs only)

## 4) Changed Files

핵심 변경 파일을 나열해 주세요.

- `path/to/file-a`
- `path/to/file-b`

## 5) Validation

실행한 명령과 결과를 그대로 남겨 주세요.

```bash
# example
./tools/common-component-map-audit.sh . /tmp/component-map-report.md
./tools/migration-lane-check.sh . <v4.3|v5.0-beta> /tmp/migration-check.md
./tools/standard-readiness-check.sh . /tmp/standard-readiness-report.md
./tools/standard-readiness-dashboard.sh /tmp/standard-readiness-report.md /tmp/standard-readiness-summary.md /tmp/standard-readiness-badge.json
./tools/reference-repo-manifest-check.sh references/repos.manifest.yml /tmp/reference-repo-manifest-report.md
./tools/pre-upload-full-review.sh . /tmp/pre-upload-review-report.md
```

## 6) Risk and Rollback

1. 영향 범위
2. 예상 리스크
3. 롤백 방법

## 7) Checklist

- [ ] 버전 혼합 가능성을 점검했다.
- [ ] 공통컴포넌트 재사용 여부를 검토했다.
- [ ] 변경 이유와 범위를 설명했다.
- [ ] 검증 명령과 결과를 첨부했다.
- [ ] 문서/프롬프트 탐색 동선을 깨지 않았다.
- [ ] 계약/흐름/도구 변경 시 `CHANGELOG.md`를 갱신했다.
