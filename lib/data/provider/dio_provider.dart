import 'package:dio/dio.dart';
import 'package:emotion_map_app/data/service/auth_service.dart';
import 'package:emotion_map_app/generate/api/auth_api.dart';
import 'package:emotion_map_app/generate/model/auth_login_request.dart';
import 'package:emotion_map_app/generate/model/auth_refresh_request.dart';
import 'package:emotion_map_app/provider/app_provider.dart';
import 'package:emotion_map_app/util/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio();
  final secureStorage = ref.watch(secureStorageProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  // 여러 요청이 동시에 401을 받아도 재인증 시도는 하나만 진행되도록 공유한다.
  Future<String?>? reauthFuture;
  Future<String?> reauthenticate() {
    return reauthFuture ??= _reauthenticate(
      dio,
      apiUrl,
      secureStorage,
    ).whenComplete(() => reauthFuture = null);
  }

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.read(
          key: AuthService.accessTokenKey,
        );
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        final isAuthEndpoint = error.requestOptions.path.startsWith(
          '/auth/',
        );
        if (error.response?.statusCode != 401 || isAuthEndpoint) {
          return handler.next(error);
        }

        final newAccessToken = await reauthenticate();
        if (newAccessToken == null) {
          return handler.next(error);
        }

        try {
          final retryOptions = error.requestOptions;
          retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          final response = await dio.fetch(retryOptions);
          handler.resolve(response);
        } catch (_) {
          handler.next(error);
        }
      },
    ),
  );
  dio.interceptors.add(dioLogger);

  return dio;
}

/// Access Token 만료(401) 시 Refresh Token으로 재발급받고, 그마저 만료/무효면
/// deviceId로 재로그인해 복구한다. 이 앱은 익명 device-id 로그인이라 재로그인에
/// 사용자 입력이 필요 없어, 화면 전환 없이 조용히 새 토큰을 받아올 수 있다.
Future<String?> _reauthenticate(
  Dio dio,
  String apiUrl,
  FlutterSecureStorage secureStorage,
) async {
  final authApi = AuthApi(dio, baseUrl: apiUrl);

  final refreshToken = await secureStorage.read(
    key: AuthService.refreshTokenKey,
  );
  if (refreshToken != null) {
    try {
      final response = await authApi.refresh(
        authRefreshRequest: AuthRefreshRequest(refreshToken: refreshToken),
      );
      final token = response.data;
      if (token?.accessToken != null) {
        await secureStorage.write(
          key: AuthService.accessTokenKey,
          value: token!.accessToken,
        );
        await secureStorage.write(
          key: AuthService.refreshTokenKey,
          value: token.refreshToken,
        );
        return token.accessToken;
      }
    } catch (_) {
      // refresh token도 만료/무효 - 아래에서 재로그인으로 복구를 시도한다.
    }
  }

  final deviceId = await secureStorage.read(key: AuthService.deviceIdKey);
  if (deviceId == null) return null;

  try {
    final response = await authApi.login(
      authLoginRequest: AuthLoginRequest(deviceId: deviceId),
    );
    final token = response.data?.token;
    if (token?.accessToken == null) return null;
    await secureStorage.write(
      key: AuthService.accessTokenKey,
      value: token!.accessToken,
    );
    await secureStorage.write(
      key: AuthService.refreshTokenKey,
      value: token.refreshToken,
    );
    return token.accessToken;
  } catch (_) {
    return null;
  }
}
