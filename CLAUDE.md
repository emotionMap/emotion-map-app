# EmotionMap 프론트엔드 (emotion_map_app)

감정연결지도 — 위치 기반의 완전 익명 감정 게시판. 이 저장소는 Flutter 프론트엔드이며, 백엔드는 별도 저장소(`emotion-map-backend`, Spring Boot)에 있습니다.

## 스택

- Flutter (SDK ^3.10.4), FVM으로 버전 고정
- Riverpod(hooks_riverpod + riverpod_generator) + Flutter Hooks
- Auto Route (라우트 정의: `lib/provider/router_provider.dart`)
- Retrofit + Dio (API 클라이언트), Freezed + json_serializable (모델)
- flutter_secure_storage(토큰) / shared_preferences

## 인증 방식 (중요)

소셜 로그인(카카오/네이버/애플/구글)은 **완전히 제거**되었습니다. 현재는 기기 식별자(deviceId) 기반 익명 로그인만 사용합니다.

- `lib/module/onboard/` — 앱 최초 진입 시 `deviceId`로 로그인 시도(`startAnonymousLogin`), 위치 설정 여부(`locationSet`)에 따라 `MainTabsRoute` 또는 `LocationSetupRoute`로 분기.
- `lib/module/location/` — 위치 설정은 최초 필수 온보딩 단계. 백엔드 JWT의 `locationSet` 클레임으로 게이팅됨.
- `lib/data/provider/dio_provider.dart` — 401 발생 시 `/auth/refresh` 재시도, 실패하면 저장된 deviceId로 재로그인 후 원 요청 재시도하는 인터셉터. 동시 401은 하나의 재인증 시도를 공유.
  - **알아둘 것**: 이 401→refresh→retry 흐름은 실제 30분 토큰 만료 상황에서 end-to-end로 검증된 적이 아직 없음 (2026-09-15 기준). 관련 이슈를 만지게 되면 로그인 후 30분 이상 대기 → 인증 필요 요청 트리거 → `/auth/refresh` 호출 및 재시도 성공 여부를 로그로 직접 확인할 것.
- `pubspec.yaml`에 소셜 로그인 패키지(`flutter_naver_login`, `kakao_flutter_sdk_user`, `google_sign_in`, `sign_in_with_apple`)가 아직 남아있으나 코드에서 미사용 — 정리 대상 후보.

## 화면/모듈 구성 (`lib/module/`)

- `onboard/` — 기기ID 익명 로그인
- `location/` — 위치 설정 (최초 필수)
- `main_tabs/` — 하단 탭 내비게이션 (피드/글쓰기/지도/마이페이지)
- `feed/` — 피드: 페이지네이션, 좋아요, 감정 칩 (공용 훅으로 구현)
- `write/` — 글쓰기
- `post/` — 게시글 상세/수정 + 댓글. 댓글은 대댓글 무제한 중첩 트리 구조 (백엔드가 평탄한 쿼리 후 트리로 조립해서 응답)
- `map/` — 지도: 서울 25개 구 실제 경계 표시, day/night 스타일 전환(지도 화면만 해당), 구 탭 시 해당 지역 피드로 이동(`region_feed_view`)
- `mypage/` — 감정 통계(최근 7/30일) + 내가 쓴 글

## 공용 레이어

- `lib/style/` — 디자인 시스템: `colors.dart`, `decorations.dart`, `text_styles.dart`. 브랜드 컬러는 테라코타(`#C97B5A`) & 크림(`#FBF3EC`), 텍스트는 웜 다크브라운(`#4A3B33`). 지도 화면만 day/night 별도 스타일 보유.
- `lib/widget/` — 공용 위젯 (TopBar, SafeArea 래퍼, 이미지, 스크롤 유틸 등). **하드코딩 금지, 공용 요소는 반드시 컴포넌트화** — 특히 하단/상단 탭 등 여러 화면에서 재사용되는 요소는 단독으로 만들지 말고 기존 공용 위젯을 확장할 것.
- `lib/data/service/` — 도메인별 API 서비스: `auth`, `posts`, `comments`, `map`, `location`, `emotion`.
- `lib/generate/` — OpenAPI Generator로 자동 생성된 API/모델 코드. **직접 수정 금지** — 백엔드 API가 바뀌면 `make gen`으로 재생성.

## 자주 쓰는 명령어

```bash
fvm use                  # Flutter 버전 고정
make clean                # pub get + precache + pod install + spider + build_runner
make watch                 # build_runner watch 모드
make gen                   # 백엔드 Swagger로부터 API 클라이언트 재생성 (.env.script의 SWAGGER_URL 사용)
flutter run --flavor dev   # 개발 실행
```

## 백엔드 연동 시 확인할 것

API 계약/엔티티 구조는 이 저장소에 없습니다. 백엔드 저장소(`emotion-map-backend`)의 `CLAUDE.md`와 `docs/entity-summary.md`를 먼저 확인하세요. 백엔드 로컬 Swagger UI: `http://localhost:8080/swagger-ui/index.html`.
