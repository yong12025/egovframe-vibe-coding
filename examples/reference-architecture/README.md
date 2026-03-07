# Example: Reference Architecture Blueprint

실전 레퍼런스 아키텍처의 모듈/흐름/검증 항목을 적용한 예시입니다.

## Scenario

- 버전 라인: v5.0 beta
- 시작점: Boot (필요 시 MSA로 분리 가능)
- 목표: 공통컴포넌트 재사용 + 모듈 경계 명확화 + 운영 검증 가능성 확보

## Module Set

1. auth: 로그인/인가
2. board: 게시글/검색/페이징
3. common-code: 도메인 코드셋
4. audit-log: 감사 이벤트
5. batch: 정기 집계/재처리

## Architecture Flow

1. Controller -> Service -> Mapper/Repository
2. 공통컴포넌트 우선 적용 후 커스터마이징
3. 운영 이벤트는 audit-log 파이프라인으로 통합

## Validation

1. `docs/12-delivery-checklist.md`
2. `tools/convention-recommend.sh`
3. `prompts/review/12-convention-similarity-audit.md`
4. `tools/common-component-map-audit.sh`
5. `tools/migration-lane-check.sh`

## Related

- `docs/18-reference-architecture.md`
- `examples/convention-audit-reports/README.md`
