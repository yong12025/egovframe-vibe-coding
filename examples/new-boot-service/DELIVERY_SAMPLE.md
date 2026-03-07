# Delivery Sample: Notice Module

이 문서는 `prompts/core/*` + `prompts/generators/01-crud-from-ddl.md` 실행 결과 예시입니다.

## 1. 작업 요약

- 버전 라인: `v5.0 beta`
- 시작점: `Boot`
- 모듈: `notice`
- 구현 범위: 공지 CRUD + 목록 검색 + 페이징

## 2. Convention Recommendation Contract

- `selected_profile`: `egov-fullstack-modern`
- `confidence_score`: `86`
- `top_reasons`:
1. greenfield 모드에서 현대 표준 조합 추천
2. v5.0 beta 라인과 modern profile 정합
3. Java + SQL 혼합 자산 기준으로 확장성 확보
- `alternatives`: `egov-java-spring`, `egov-sql-standard`
- `migration_cost`: `low`

## 3. 변경 파일 목록 (예시)

- `src/main/java/.../notice/domain/NoticeEntity.java`
- `src/main/java/.../notice/dto/NoticeCreateRequest.java`
- `src/main/java/.../notice/dto/NoticeResponse.java`
- `src/main/java/.../notice/repository/NoticeMapper.java`
- `src/main/java/.../notice/service/NoticeService.java`
- `src/main/java/.../notice/service/NoticeServiceImpl.java`
- `src/main/java/.../notice/controller/NoticeController.java`
- `src/test/java/.../notice/NoticeServiceTest.java`

## 4. 공통컴포넌트 재사용 판단

- 로그인/권한: 공통컴포넌트 재사용
- 게시판: 요구사항 유사 시 기존 게시판 컴포넌트 확장 검토
- 이번 범위: 공지 전용 API이므로 신규 notice 모듈 생성

## 5. 실행/검증 명령 (예시)

```bash
./gradlew clean test
./gradlew bootRun
./tools/convention-recommend.sh . --lane v5.0-beta --mode auto --output /tmp/convention-recommend-report.md
curl -X GET 'http://localhost:8080/api/notices?page=0&size=20&keyword=공지'
```

## 6. 리스크/가정

- 가정: DB 인덱스(`created_at`, `title`)가 존재함
- 리스크: 검색 조건 확장 시 동적 쿼리 복잡도 증가

## 7. 완료 체크

- 버전 혼합 없음
- 컨벤션 추천 근거 포함
- 입력 검증/예외 처리 포함
- 테스트 코드 포함
- 실행 명령 포함
