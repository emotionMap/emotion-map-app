import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:loader_overlay/loader_overlay.dart';

enum LoginType { kakao }

void onLogin(WidgetRef ref, LoginType type) async {
  final context = ref.context;

  context.loaderOverlay.show();

  final authService = ref.read(authServiceProvider);

  switch (type) {
    case LoginType.kakao:
      successKakaoLogin(OAuthToken auth) async {
        try {
          await authService.login(type: type, accessToken: auth.accessToken);

          if (!context.mounted) return;
          context.loaderOverlay.hide();
        } catch (e) {
          if (!context.mounted) return;
          context.loaderOverlay.hide();
        }
      }

      if (await isKakaoTalkInstalled()) {
        try {
          final auth = await UserApi.instance.loginWithKakaoTalk();

          await successKakaoLogin(auth);
        } catch (error) {
          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            if (!context.mounted) return;
            context.loaderOverlay.hide();
            return;
          }

          debugPrint('카카오톡으로 로그인 실패 $error');
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          try {
            final auth = await UserApi.instance.loginWithKakaoAccount();

            await successKakaoLogin(auth);
          } catch (error) {
            debugPrint('카카오계정으로 로그인 실패 $error');
            if (!context.mounted) return;
            context.loaderOverlay.hide();
          }
        }
      } else {
        try {
          final auth = await UserApi.instance.loginWithKakaoAccount();

          await successKakaoLogin(auth);
        } catch (error) {
          if (!context.mounted) return;
          context.loaderOverlay.hide();
        }
      }

      break;
  }
}
