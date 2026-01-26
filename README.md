# Emotion Map App

감정연결지도 Flutter

## 기술 스택

- **Framework**: Flutter (SDK ^3.10.4)
- **State Management**: Riverpod + Hooks
- **Routing**: Auto Route
- **Social Login**: Naver, Kakao, Google, Apple
- **CI/CD**: Fastlane, Firebase Distribution

## 시작하기

### 환경 설정

```bash
# Flutter 버전 관리 (FVM 사용 중)
fvm use

# 의존성 설치 및 코드 생성
make clean
```

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

- `lib/` - 애플리케이션 소스 코드
- `assets/` - 리소스 파일 (이미지, 폰트)
- `android/` - Android 네이티브 설정
- `ios/` - iOS 네이티브 설정
