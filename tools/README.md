# Tools

저장소 운영 자동화 도구 모음입니다.

## Available

1. `common-component-map-audit.sh`
- 공통컴포넌트 재사용 가능성 탐지 리포트 생성

2. `migration-lane-check.sh`
- 목표 버전 라인(v4.3 / v5.0-beta) 정합성 점검 리포트 생성

3. `convention-recommend.sh`
- 코드 자산/설정 시그널을 스캔해 컨벤션 프로파일 추천 리포트 생성

4. `standard-readiness-check.sh`
- 표준 repo 기준(필수 자산/스모크 테스트) 충족 여부 리포트 생성

5. `standard-readiness-dashboard.sh`
- 준비도 리포트를 요약 대시보드/배지 JSON으로 변환

6. `reference-repo-manifest-check.sh`
- 버전 라인 분리 저장소 매니페스트 정합성 점검 리포트 생성

7. `pre-upload-full-review.sh`
- 업로드 전 상황별 전체 검토 + 공식 이탈 라벨 리포트 생성

## Quick Run

```bash
./tools/common-component-map-audit.sh <PROJECT_DIR> [OUTPUT_MD]
./tools/migration-lane-check.sh <PROJECT_DIR> <v4.3|v5.0-beta> [OUTPUT_MD]
./tools/convention-recommend.sh <PROJECT_DIR> --lane <v4.3|v5.0-beta> --mode <auto|existing|greenfield> [--output <path>]
./tools/standard-readiness-check.sh <REPO_DIR> [OUTPUT_MD]
./tools/standard-readiness-dashboard.sh <READINESS_REPORT_MD> [OUTPUT_SUMMARY_MD] [OUTPUT_BADGE_JSON]
./tools/reference-repo-manifest-check.sh <MANIFEST_YML> [OUTPUT_MD]
./tools/pre-upload-full-review.sh <REPO_DIR> [OUTPUT_MD]
```
