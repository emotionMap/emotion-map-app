//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_auth_login_response.dart';
import 'package:emotion_map_app/generate/model/api_response_jwt_token.dart';
import 'package:emotion_map_app/generate/model/api_response_void.dart';
import 'package:emotion_map_app/generate/model/auth_login_request.dart';
import 'package:emotion_map_app/generate/model/auth_refresh_request.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  /// 로그인
  /// 기기 식별자(deviceId) 기반 익명 로그인 - 본인인증 없음, 없는 deviceId면 새 계정 생성
  ///
  /// Parameters:
  /// * [authLoginRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/login')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseAuthLoginResponse> login({
    @Body() required AuthLoginRequest authLoginRequest,
    CancelToken? cancelToken,
  });

  /// 로그아웃
  /// Refresh Token 무효화
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/logout')
  Future<ApiResponseVoid> logout({CancelToken? cancelToken});

  /// 토큰 갱신
  /// Refresh Token으로 새 Access Token 발급
  ///
  /// Parameters:
  /// * [authRefreshRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/refresh')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseJWTToken> refresh({
    @Body() required AuthRefreshRequest authRefreshRequest,
    CancelToken? cancelToken,
  });
}
