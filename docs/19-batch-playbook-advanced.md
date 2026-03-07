# Batch Playbook (Advanced)

배치 운영 안정성을 높이기 위한 실전 플레이북입니다.

---

## 1. 목표

- 중복 실행 방지
- 실패 재처리 표준화
- 장애 원인 추적 가능성 확보

---

## 2. 기본 정책

1. 잡 식별자(Job Key) 고정
2. 멱등성 키(Idempotency Key) 적용
3. 실패 이력 보관 및 재처리 큐 운영

---

## 3. 실행 모델

### 실행 전

- 스케줄/락 정책 확인
- 입력 데이터 범위 확인

### 실행 중

- 처리량/오류율/지연시간 모니터링
- 스텝별 실패 임계치 감시

### 실행 후

- 성공/실패 건수 기록
- 실패 건 재처리 후보 분리

---

## 4. 재처리 전략

1. 실패 유형 분류(일시/영구)
2. 일시 실패는 재시도 횟수 제한 내 자동 재시도
3. 영구 실패는 수동 검수 후 보정 재처리

---

## 5. 검증 명령

```bash
./tools/common-component-map-audit.sh <PROJECT_DIR>
./tools/migration-lane-check.sh <PROJECT_DIR> <v4.3|v5.0-beta>
```

연계 프롬프트

- `prompts/generators/04-batch-job.md`
- `prompts/generators/14-batch-retry-recovery.md`

---

## 6. 운영 체크리스트

- [ ] 중복 실행 방지 정책이 적용되었는가
- [ ] 실패 재처리 절차가 문서화되었는가
- [ ] 처리량/오류율 지표를 수집하는가
- [ ] 장애 시 롤백/복구 경로가 명시되었는가
