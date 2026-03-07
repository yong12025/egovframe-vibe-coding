# Convention Templates

컨벤션 추천 엔진 v1에서 사용하는 프로파일별 샘플 설정 템플릿입니다.

## Included Profiles

- `egov-legacy-safe`
- `egov-java-google`
- `egov-java-spring`
- `egov-ts-prettier-eslint`
- `egov-sql-standard`
- `egov-fullstack-modern`

## How To Use

1. `tools/convention-recommend.sh`로 추천 프로파일을 확인합니다.
2. 해당 프로파일 디렉터리의 템플릿을 프로젝트에 복사합니다.
3. 신규/변경 파일부터 점진 적용합니다.
4. `prompts/review/12-convention-similarity-audit.md`로 유사도를 점검합니다.

## Quick Command

```bash
./tools/convention-recommend.sh <PROJECT_DIR> --lane <v4.3|v5.0-beta> --mode auto
```
