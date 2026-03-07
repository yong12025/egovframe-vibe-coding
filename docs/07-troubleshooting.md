# Troubleshooting

전자정부프레임워크 프로젝트에서 자주 발생하는 문제와 점검 순서입니다.

---

## 1) 버전 혼합 의심

증상

- 빌드 실패
- 런타임 클래스 충돌

점검

1. 빌드 의존성 메이저 버전 확인
2. `docs/agent-rules.md`의 Version Lane 규칙 대조
3. 혼합 항목 제거 후 재빌드

---

## 2) 보안 설정 이슈

증상

- 로그인/권한 체크 누락
- 헤더 설정 불일치(`xframeOptions` 등)

점검

1. 인증/인가 필터 체인 확인
2. 권한 매핑 규칙 확인
3. 민감정보 로그 노출 여부 점검

---

## 3) 배치 처리 장애

증상

- 대용량 처리 중 실패
- 중복 실행/재처리 오류

점검

1. 잡/스텝 단위 리트라이 정책 확인
2. 중복 실행 방지 키 확인
3. 실패 레코드 재처리 전략 점검

---

## 4) 검색 품질 이슈

증상

- 검색 정확도 저하
- 응답 속도 문제

점검

1. 인덱스/쿼리 전략 확인
2. 벡터 검색 적용 시 데이터 전처리 점검
3. 캐시/스토리지 계층 확인

---

## 케이스북

실무 케이스 기반 점검은 아래 문서를 사용합니다.

- `docs/14-troubleshooting-casebook.md`
- `docs/19-batch-playbook-advanced.md`
- `docs/20-security-playbook-advanced.md`
- `docs/21-runtime-operations-playbook.md`

---

## FAQ

- https://www.egovframe.go.kr/home/sub.do?menuNo=68
