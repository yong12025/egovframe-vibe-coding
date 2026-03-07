# Reference Architecture (Practical)

전자정부프레임워크 실무 프로젝트에서 바로 사용할 수 있는 참조 아키텍처입니다.

---

## 1. Target Profile

- 기본 라인: v5.0 beta
- 시작점: Boot
- 확장 옵션: MSA 분리
- 핵심 원칙: Version Lane Lock + Reuse First + Verify Before Done

---

## 2. Layer and Module Boundary

### 공통 레이어

1. Controller: 요청/응답, 검증, 예외 매핑
2. Service: 비즈니스 규칙, 트랜잭션 경계
3. Persistence: Mapper/Repository

### 권장 모듈

1. auth
2. board
3. common-code
4. audit-log
5. batch

---

## 3. Reuse Strategy

신규 구현 전 아래 항목을 우선 재사용 검토합니다.

- 로그인
- 게시판
- 사용자/권한
- 공통코드
- 로그/배치

검토 자동화

- `tools/common-component-map-audit.sh`

---

## 4. Runtime and Operations

### 운영 최소 구성

1. 에러/감사 로그 추적 가능
2. 배치 실패 재처리 가능
3. 버전 라인 혼합 탐지 가능

운영 점검 자동화

- `tools/migration-lane-check.sh`

---

## 5. Delivery Flow

1. `prompts/core/01-project-kickoff.md`
2. `prompts/core/02-version-lock.md`
3. `prompts/core/03-reuse-audit.md`
4. 기능별 생성 프롬프트(`prompts/generators/*`)
5. 리뷰 프롬프트(`prompts/review/*`)
6. `docs/12-delivery-checklist.md`

---

## 6. Validation Checklist (Architecture)

- [ ] 버전 라인이 명시되었는가
- [ ] 공통컴포넌트 재사용 판단 근거가 있는가
- [ ] 모듈 경계(auth/board/common-code/audit-log/batch)가 문서화되었는가
- [ ] 운영 검증 명령이 포함되었는가
- [ ] 리스크와 가정이 명시되었는가

---

## 7. Practical Example

- `examples/reference-architecture/README.md`

---

## 8. Related Documents

- `docs/10-repository-architecture.md`
- `docs/12-delivery-checklist.md`
- `docs/17-q4-priority-plan.md`
- `docs/19-batch-playbook-advanced.md`
- `docs/20-security-playbook-advanced.md`
- `docs/21-runtime-operations-playbook.md`
- `docs/32-reference-repo-split-operations.md`
- `references/repos.manifest.yml`
