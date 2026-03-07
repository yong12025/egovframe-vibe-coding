# Delivery Checklist

작업 완료 전 반드시 확인하는 체크리스트입니다.

---

## A. Version Integrity

- [ ] 버전 라인(v4.3/v5.0 beta)이 명시되었다.
- [ ] 의존성/설정/코드가 같은 라인으로 정렬되었다.
- [ ] 혼합 의심 항목이 제거되었다.

---

## B. Reuse First

- [ ] 공통컴포넌트 재사용 가능성을 먼저 점검했다.
- [ ] 재사용 가능한 기능을 신규 구현으로 중복 개발하지 않았다.
- [ ] 신규 구현 사유를 문서화했다.

---

## C. Convention Fit

- [ ] `selected_profile`이 명시되었다.
- [ ] `confidence_score`와 추천 근거(top reasons)가 포함되었다.
- [ ] 기존 프로젝트는 유사도 우선 전략을 따랐다.
- [ ] 신규 프로젝트는 `egov-fullstack-modern` 기본값을 검토했다.

---

## D. Implementation Quality

- [ ] DDL -> Domain -> Mapper -> Service -> Controller 순서를 지켰다.
- [ ] 입력 검증/예외 처리/로그가 포함되었다.
- [ ] 테스트 또는 최소 검증 시나리오가 존재한다.

---

## E. Security Basics

- [ ] 인증/인가 흐름이 적용되었다.
- [ ] 입력값 검증이 적용되었다.
- [ ] 민감정보 로그 노출이 없다.

---

## F. Delivery Format

- [ ] 작업 요약
- [ ] selected_profile / confidence_score
- [ ] top_reasons / alternatives
- [ ] 변경 파일 목록
- [ ] 코드/설정
- [ ] 실행/검증 명령
- [ ] 리스크 및 가정

---

## G. Standard Repo Operations

- [ ] `tools/standard-readiness-check.sh` 결과를 확인했다.
- [ ] 필요 시 `tools/standard-readiness-dashboard.sh`로 요약/배지 결과를 생성했다.
- [ ] 분리 운영 중이면 `tools/reference-repo-manifest-check.sh` 결과를 확인했다.
- [ ] 계약/흐름/도구 변경이 있으면 `CHANGELOG.md`를 갱신했다.

모든 항목을 만족하면 작업 완료로 간주합니다.
