# eGovFrame Agent Rules (Production Edition)

이 문서는 전자정부프레임워크 프로젝트를 AI Agent로 설계/구현/검수할 때의 **운영 표준**입니다.
목표는 "빠르게 만들기"가 아니라 **혼합 오류 없이, 재사용 우선으로, 검증 가능한 결과를 만드는 것**입니다.

---

## 0. Core Principles

1. Version Lane First
2. No Mixed Stack
3. Convention Fit First
4. Reuse Before Build
5. File-Level Deliverables
6. Verify Before Done
7. Preserve Existing Logic First (운영/레거시)

---

## 1. Version Lane Lock (필수)

모든 작업은 먼저 버전 라인을 잠급니다.

- Lane A: `v4.3` 계열
- Lane B: `v5.0 beta` 계열

버전 미확정 상태에서는 코드 생성을 시작하지 않습니다.

### 1.1 잠금 체크 항목

- Spring Boot 메이저
- Spring Framework 메이저
- Security/Batch 메이저
- 빌드 파일(`pom.xml`/`build.gradle`) 의존성
- 템플릿/스타터 유형(Template, Boot, MSA, Batch, Mobile, AI)

### 1.2 금지 사항

- v4.3 코드 패턴 + v5 설정 파일 혼합
- v5 API 스타일 + v4 라이브러리 결합
- 같은 모듈 내 다중 버전 공존

---

## 2. Input Contract (요청 수신 규격)

Agent는 작업 시작 전에 아래 정보를 확보합니다.

- 대상 버전: `v4.3` 또는 `v5.0 beta`
- 프로젝트 타입: Template/Boot/MSA/Batch/Mobile/AI
- 컨벤션 우선순위: 유사/균형/최신 중 기본 전략
- 기능 범위: CRUD/Auth/Board/Batch/Integration
- 데이터 소스: 테이블 정의 또는 기존 스키마
- 비기능 요구: 보안/성능/로깅/배포 제약

입력이 불완전하면 Agent는 합리적 가정을 선언하고 진행합니다.

---

## 2.1 Operator Safety Protocol (기존 로직 보존)

운영/레거시 프로젝트에서는 아래를 기본 규칙으로 적용합니다.

- 요청 범위 밖의 변경 금지
- 기존 API/DB/배치 동작 보존 우선
- 영향도 보고 후 최소 변경 적용

---

## 3. Execution Protocol (작업 프로토콜)

### Phase 1. Discover

- 버전 라인 잠금
- 컨벤션 추천 리포트 생성(`tools/convention-recommend.sh`)
- 기존 공통컴포넌트 사용 가능성 조사
- 기존 코드 충돌 위험 탐지

### Phase 2. Plan

- 변경 파일 목록 제시
- 신규 생성/수정/삭제 범위 확정
- 리스크와 롤백 지점 명시

### Phase 3. Build

- 아래 표준 순서로 생성

1. DDL
2. Domain(VO/DTO/Entity)
3. Mapper/Repository
4. Service
5. Controller/API
6. View 또는 API Contract
7. Test Code

### Phase 4. Verify

- 컴파일/정적 점검
- 핵심 흐름 테스트
- 보안 체크(인증/인가/입력값/로그 노출)

### Phase 5. Deliver

- 작업 요약
- `selected_profile` / `confidence_score`
- `top_reasons` / `alternatives`
- 파일별 변경 포인트
- 실행 방법
- 검수 체크리스트
- 표준 준비도 요약(필요 시)
- `CHANGELOG.md` 갱신 여부(계약/흐름/도구 변경 시)

---

## 4. Reuse-First Policy (공통컴포넌트 우선)

아래 기능은 신규 구현 전에 공통컴포넌트 사용 여부를 반드시 확인합니다.

- 로그인
- 사용자/권한 관리
- 게시판
- 공통코드
- 메뉴관리
- 로그관리
- 배치관리

공통컴포넌트 재사용이 가능한데 신규 구현으로 우회하는 것은 금지합니다.

---

## 5. Output Contract (산출물 형식)

모든 응답/산출물은 다음 구조를 지킵니다.

1. 작업 요약
2. `selected_profile` / `confidence_score`
3. `top_reasons` / `alternatives`
4. 변경 파일 목록
5. 핵심 코드/설정
6. 실행 및 검증 명령
7. 리스크와 가정
8. 완료 정의(DoD) 체크
9. 표준 준비도 요약(요청 또는 릴리스 직전)
10. changelog 갱신 내역(적용 시)

---

## 6. Quality Gates

### 6.1 Build Gate

- 버전 라인 일관성 확인
- 의존성 충돌 없음
- 빌드 성공

### 6.2 Runtime Gate

- 핵심 유스케이스 정상 동작
- 예외 처리 및 오류 메시지 일관성

### 6.3 Security Gate

- 인증/인가 흐름 존재
- SQL Injection/XSS/CSRF 기본 방어
- 민감정보 로그 미노출

### 6.4 Operability Gate

- 로깅 포인트 포함
- 설정 파일 프로필 분리
- 장애 분석 가능한 에러 컨텍스트

### 6.5 Convention Gate

- 컨벤션 추천 근거가 기록되었는가
- 기존 프로젝트는 유사도 우선 전략을 따르는가
- 신규 프로젝트는 `egov-fullstack-modern` 기본값을 따르는가

### 6.6 Standard Repo Gate

- `tools/standard-readiness-check.sh` 결과가 PASS인가
- 필요 시 `tools/standard-readiness-dashboard.sh` 요약 결과를 제공했는가
- 계약/흐름/도구 변경 시 `CHANGELOG.md`를 갱신했는가

### 6.7 Operator Safety Gate

- 변경이 요청 범위를 벗어나지 않았는가
- 기존 API/DB/배치 동작 보존 여부를 점검했는가
- 영향도 보고와 최소 변경 근거를 남겼는가

---

## 7. Standard Playbooks

### 7.1 CRUD Playbook

- DDL -> Domain -> Mapper -> Service -> Controller -> Test
- 조회 조건/페이징/정렬 규칙 명시
- 입력 검증 및 예외 코드를 표준화

### 7.2 Auth Playbook

- 로그인 + 권한 매핑 + 접근 제어
- 권한 누락 시 차단 규칙 검증
- 세션/토큰 전략 명시

### 7.3 Board Playbook

- 공통컴포넌트 재사용 우선
- 첨부파일/검색/페이징 표준 적용

### 7.4 Batch Playbook

- 잡 정의/스케줄/재처리 정책
- 실패 재시도/중복 실행 방지

---

## 8. Git and Change Discipline

- 한 작업은 한 목적에 집중
- 대규모 리팩터링과 기능 추가를 한 PR에 혼합 금지
- 생성 코드에도 테스트 또는 최소 검증 시나리오 포함

---

## 9. Definition of Done (완료 기준)

아래를 모두 만족해야 완료로 간주합니다.

- 버전 라인 잠금 상태에서 일관 동작
- 컨벤션 프로파일 선택 근거 문서화
- 공통컴포넌트 재사용 판단 근거 문서화
- 기능 요구 + 기본 보안 요구 충족
- 실행/검증 명령 제공
- 남은 리스크와 후속 작업 명시
- 릴리스/공개 전 표준 준비도 점검 결과 확보
- 계약/흐름/도구 변경 시 changelog 갱신

---

## 10. Anti-Patterns (금지 패턴)

- 버전 불명 상태에서 코드 생성 시작
- 공통컴포넌트 확인 없이 신규 구현
- 테스트/검증 생략 후 완료 처리
- 설정만 변경하고 영향 범위 분석 누락
- 로그/예외 정책 없는 API 배포
- 컨벤션 추천 없이 예시 코드부터 생성

---

## 11. Reference

- https://www.egovframe.go.kr
- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:dev4.3:gettingstarted
- https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:com:v4.3:init_guide
- `docs/23-convention-catalog.md`
- `docs/24-convention-recommendation-logic.md`
