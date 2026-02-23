import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/auth_api.dart';
import 'package:emotion_map_app/generate/model/api_response_auth_login_response.dart';
import 'package:emotion_map_app/generate/model/auth_login_request.dart';
import 'package:emotion_map_app/module/onboard/onboard_provider.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthService {
  // ignore: unused_field
  final Ref _ref;
  final AuthApi _authApi;

  AuthService(this._ref, this._authApi);

  Future<ApiResponseAuthLoginResponse> login({
    required LoginType type,
    required String accessToken,
  }) async {
    try {
      AuthLoginRequestProviderEnum provider;

      switch (type) {
        case LoginType.kakao:
          provider = .kakao;
          break;
        case LoginType.naver:
          provider = .naver;
      }

      return await _authApi.login1(
        authLoginRequest: AuthLoginRequest(
          provider: provider,
          accessToken: accessToken,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
