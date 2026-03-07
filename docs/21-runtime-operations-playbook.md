# Runtime Operations Playbook

운영 단계에서 장애 탐지/진단/복구를 빠르게 수행하기 위한 플레이북입니다.

---

## 1. 목표

- 장애 탐지 시간 단축
- 원인 분석 재현성 확보
- 복구 절차 표준화

---

## 2. 운영 지표

1. 오류율(Error Rate)
2. 응답시간 지연(Latency)
3. 배치 실패율
4. 인증 실패율

---

## 3. 장애 대응 흐름

1. 증상 수집(로그/에러/변경 이력)
2. 케이스북 매칭
3. 우선순위 진단(P1/P2/P3)
4. 수정/롤백 실행
5. 재검증 및 사후 기록

---

## 4. 자동 진단 연계

- 케이스북: `docs/14-troubleshooting-casebook.md`
- 진단 프롬프트: `prompts/review/04-troubleshooting-auto-diagnosis.md`

---

## 5. 검증 명령

```bash
./tools/common-component-map-audit.sh <PROJECT_DIR> /tmp/component-map-report.md
./tools/migration-lane-check.sh <PROJECT_DIR> <v4.3|v5.0-beta> /tmp/migration-check.md
```

---

## 6. 운영 체크리스트

- [ ] 장애 대응 절차가 문서화되어 있는가
- [ ] 진단 결과의 근거(로그/파일/명령)가 남는가
- [ ] 롤백 기준과 Go/No-Go 기준이 있는가
- [ ] 사후 분석(Postmortem) 기록이 생성되는가
