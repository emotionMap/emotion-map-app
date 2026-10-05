# Emotion Map App

감정연결지도 Flutter 앱

## 기술 스택

- **Framework**: Flutter (SDK ^3.10.4), FVM으로 버전 관리
- **State Management**: Riverpod (hooks_riverpod + riverpod_generator) + Flutter Hooks
- **Routing**: Auto Route
- **API Client**: Retrofit + Dio, `generate/` 하위 코드는 백엔드 Swagger로부터 자동 생성 (직접 수정 금지)
- **Model**: Freezed + json_serializable
- **Storage**: flutter_secure_storage(토큰), shared_preferences
- **인증**: 기기 식별자(deviceId) 기반 익명 로그인 — 소셜 로그인(카카오/네이버/애플/구글)은 제거됨
- **CI/CD**: Fastlane, Firebase Distribution

> `pubspec.yaml`에는 과거 소셜 로그인 패키지(`flutter_naver_login`, `kakao_flutter_sdk_user`, `google_sign_in`, `sign_in_with_apple`)가 아직 남아있지만 `lib/` 어디에서도 참조하지 않는 사용하지 않는 의존성입니다. 정리 필요 시 제거 대상.

## 시작하기

### 환경 설정

```bash
# Flutter 버전 관리 (FVM 사용 중)
fvm use

# 의존성 설치 + 코드 생성 (freezed/riverpod/retrofit/asset)
make clean
```

### API 클라이언트 재생성

백엔드 API가 바뀌면 Swagger 스펙으로부터 `lib/generate/` 코드를 다시 생성해야 합니다.

```bash
make gen
```

`.env.script`의 `SWAGGER_URL`을 사용합니다 (백엔드 로컬 실행 시 기본값 `http://localhost:8080/...`).

### 실행

VSCode에서 실행 구성 선택 (F5):
- `dev-debug` - Development 디버그 모드
- `prod-debug` - Production 디버그 모드
- `dev-profile` - Development 프로파일 모드
- `prod-profile` - Production 프로파일 모드
- `dev-release` - Development 릴리즈 모드
- `prod-release` - Production 릴리즈 모드

또는 터미널에서:
```bash
# Development
flutter run --flavor dev

# Production
flutter run --flavor prod
```

## 프로젝트 구조

```
lib/
  asset/        # spider로 생성되는 이미지/에셋 참조
  data/
    provider/   # dio, api client, service의 riverpod provider
    service/    # 도메인별 API 서비스 (auth/posts/comments/map/location/emotion)
  enum/
  generate/     # openapi generator 자동 생성 코드 (직접 수정 금지)
  model/
  module/       # 화면 단위 기능 모듈
    onboard/       # 기기ID 익명 로그인
    location/      # 위치 설정 (최초 필수 설정 단계)
    main_tabs/     # 하단 탭 내비게이션 (피드/글쓰기/지도/마이)
    feed/          # 피드 (페이지네이션, 좋아요, 감정 칩)
    write/         # 글쓰기
    post/          # 게시글 상세, 수정, 댓글(대댓글 무제한 중첩)
    map/           # 지도 (서울 25개 구 경계, 지역별 피드)
    mypage/        # 마이페이지 (감정 통계, 내가 쓴 글)
  provider/     # 전역 provider (router 등)
  style/        # 디자인 시스템 (colors/decorations/text_styles)
  util/
  widget/       # 공용 위젯 (TopBar, Safe area, 이미지 등)
assets/         # 리소스 파일 (이미지, 폰트)
android/        # Android 네이티브 설정
ios/            # iOS 네이티브 설정
```

## 백엔드 연동

백엔드 저장소는 별도 레포(`emotion-map-backend`)입니다. API 계약이 바뀌면 백엔드의 `CLAUDE.md` / `docs/entity-summary.md`를 먼저 확인하고 `make gen`으로 클라이언트를 재생성하세요.
