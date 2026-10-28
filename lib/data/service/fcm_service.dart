import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/users_api.dart';
import 'package:emotion_map_app/generate/model/fcm_token_update_request.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// FCM 디바이스 토큰 발급 + 서버 동기화.
/// 알림 수신/탭 시 딥링크 처리는 main.dart에서 담당한다 (라우터 접근이 필요해서 분리).
class FcmService {
  final UsersApi _usersApi;

  FcmService(this._usersApi);

  Stream<String> get onTokenRefresh => FirebaseMessaging.instance.onTokenRefresh;

  /// 알림 권한 요청(iOS) + 현재 기기 토큰을 서버에 등록. 로그인 직후, onTokenRefresh 발생 시 호출.
  /// 실패해도(권한 거부 등) 조용히 무시 - 푸시는 부가 기능이라 핵심 흐름(로그인 등)을 막으면 안 된다.
  Future<void> syncToken() async {
    try {
      await FirebaseMessaging.instance.requestPermission();
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) return;

      await _usersApi.updateFcmToken(
        fcmTokenUpdateRequest: FcmTokenUpdateRequest(fcmToken: token),
      );
    } on DioException catch (e) {
      debugPrint("[FCM] 토큰 동기화 실패: ${getErrorMessage(e)}");
    } catch (e) {
      debugPrint("[FCM] 토큰 동기화 중 알 수 없는 예외: $e");
    }
  }
}
