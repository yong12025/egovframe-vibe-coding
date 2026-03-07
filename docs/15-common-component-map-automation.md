# Common Component Map Automation

공통컴포넌트 재사용 가능성을 빠르게 점검하는 자동화 가이드입니다.

---

## 도구

- `tools/common-component-map-audit.sh`

---

## 사용법

```bash
./tools/common-component-map-audit.sh <PROJECT_DIR>
./tools/common-component-map-audit.sh <PROJECT_DIR> /tmp/component-map-report.md
```

예시

```bash
./tools/common-component-map-audit.sh /Users/me/workspace/my-egov-project /tmp/component-map-report.md
```

---

## 출력 내용

1. 기능별 탐지 수 요약 테이블
2. 기능별 샘플 매치 파일(최대 5개)
3. 재사용/통합 우선 권장 조치

---

## 운영 팁

- 신규 기능 착수 전 1회 실행
- 대규모 리팩터링 전후 비교 실행
- 결과를 PR 설명에 첨부하여 재사용 판단 근거로 활용
