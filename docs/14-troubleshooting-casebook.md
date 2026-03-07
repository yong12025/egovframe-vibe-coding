# Troubleshooting Casebook

실무에서 자주 부딪히는 장애 패턴과 즉시 점검 순서를 정리한 케이스북입니다.

자동 진단 프롬프트

- `prompts/review/04-troubleshooting-auto-diagnosis.md`

---

## Case 1. 버전 혼합으로 빌드 실패

증상

- 의존성 충돌
- 클래스/메서드 시그니처 불일치

점검 순서

1. `docs/01-version-lane.md` 기준으로 목표 라인을 재확인
2. `prompts/core/02-version-lock.md`로 충돌 후보 재분석
3. 메이저 버전 혼합 항목 제거 후 재빌드

---

## Case 2. 로그인은 되지만 권한이 동작하지 않음

증상

- 인증 성공 후 403 반복
- 역할 매핑 누락

점검 순서

1. 권한 모델과 URL 매핑 룰 재확인
2. `prompts/generators/02-login-rbac.md`로 정책 재생성
3. 401/403 응답 분기 테스트

---

## Case 3. 게시판 커스터마이징 후 기능 회귀

증상

- 검색/페이징 오동작
- 첨부파일 처리 실패

점검 순서

1. 공통컴포넌트 재사용 범위와 커스터마이징 범위를 분리 확인
2. `prompts/generators/03-board-reuse.md`로 변경 경계 재정의
3. 핵심 흐름(목록/상세/등록/수정/삭제) 재검증

---

## Case 4. 배치 중복 실행

증상

- 같은 잡이 중복 실행되어 데이터 중복

점검 순서

1. 스케줄/락 정책 확인
2. `prompts/generators/04-batch-job.md`로 중복 방지 정책 강화
3. 실패 재처리 정책과 충돌 여부 점검

---

## Case 5. 마이그레이션 이후 런타임 오류

증상

- v4.3 -> v5.0 beta 전환 후 런타임 예외

점검 순서

1. 호환성 리스크 맵 재작성
2. `prompts/review/03-migration-v43-to-v50.md`로 단계별 검증/롤백 재설계
3. Go/No-Go 기준 충족 여부 확인
