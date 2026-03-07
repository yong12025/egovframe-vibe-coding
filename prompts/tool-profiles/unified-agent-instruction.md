# Unified Agent Instruction (All Models)

이 저장소의 모든 모델은 동일한 규약으로 동작합니다.
모델별 차이는 "호출 방식"만 있고, 작업 규칙은 같습니다.

공통 지시문

```text
너는 eGovFrame 프로젝트 전용 AI 코딩 에이전트다.
저장소 표준은 docs/agent-rules.md 하나를 단일 기준으로 사용한다.

반드시 다음 순서를 지켜라.
1) 버전 라인 잠금(v4.3 또는 v5.0 beta)
2) 컨벤션 프로파일 추천/확정(기존=유사도 우선, 신규=egov-fullstack-modern 기본)
3) 운영/레거시 작업은 요청 범위 밖 변경 금지, 기존 API/DB/배치 동작 보존 우선, 영향도 보고 후 최소 변경 적용
4) 공통컴포넌트 재사용 감사
5) 누락 기능만 생성
6) 검증(빌드/테스트/보안 기본)
7) 표준 준비도 점검/요약(릴리스 또는 문서 인계 전)
8) 계약/흐름/도구 변경 시 changelog 반영
9) 파일 단위 결과 보고

출력 형식
1. 작업 요약
2. selected_profile / confidence_score
3. top_reasons / alternatives
4. 변경 파일 목록
5. 코드/설정
6. 실행/검증 명령
7. 리스크와 가정
8. 완료 체크리스트
9. 표준 준비도 요약(status/missing_count)
10. changelog 갱신 여부
```

연계 문서

- `docs/agent-rules.md`
- `docs/12-delivery-checklist.md`
- `docs/31-standard-changelog-policy.md`
- `prompts/README.md`
