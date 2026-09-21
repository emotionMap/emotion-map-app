import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/auth_api.dart';
import 'package:emotion_map_app/generate/model/auth_login_request.dart';
import 'package:emotion_map_app/generate/model/auth_login_response.dart';
import 'package:emotion_map_app/generate/model/jwt_token.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

/// 본인인증 없는 익명 로그인 - 기기별로 생성해 보관하는 deviceId 하나로 계정을 식별한다.
class AuthService {
  static const deviceIdKey = 'device_id';
  static const accessTokenKey = 'access_token';
  static const refreshTokenKey = 'refresh_token';

  // ignore: unused_field
  final Ref _ref;
  final AuthApi _authApi;
  final FlutterSecureStorage _secureStorage;

  AuthService(this._ref, this._authApi, this._secureStorage);

  Future<String> _getOrCreateDeviceId() async {
    final existing = await _secureStorage.read(key: deviceIdKey);
    if (existing != null) return existing;

    final newId = const Uuid().v4();
    await _secureStorage.write(key: deviceIdKey, value: newId);
    return newId;
  }

  /// 로그인 (없는 deviceId면 서버가 새 계정을 만든다) - locationSet 여부를 포함해 반환한다.
  Future<AuthLoginResponse> login() async {
    try {
      final deviceId = await _getOrCreateDeviceId();

      final response = await _authApi.login(
        authLoginRequest: AuthLoginRequest(deviceId: deviceId),
      );
      final data = response.data;
      if (data == null) {
        return Future.error("error");
      }

      final token = data.token;
      if (token != null) {
        await saveTokens(token);
      }

      return data;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<void> saveTokens(JWTToken token) async {
    final accessToken = token.accessToken;
    final refreshToken = token.refreshToken;
    if (accessToken != null) {
      await _secureStorage.write(key: accessTokenKey, value: accessToken);
    }
    if (refreshToken != null) {
      await _secureStorage.write(key: refreshTokenKey, value: refreshToken);
    }
  }

  Future<String?> getAccessToken() => _secureStorage.read(key: accessTokenKey);
}
