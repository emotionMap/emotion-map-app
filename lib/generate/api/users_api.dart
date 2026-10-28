//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_jwt_token.dart';
import 'package:emotion_map_app/generate/model/api_response_void.dart';
import 'package:emotion_map_app/generate/model/fcm_token_update_request.dart';
import 'package:emotion_map_app/generate/model/location_update_request.dart';

part 'users_api.g.dart';

@RestApi()
abstract class UsersApi {
  factory UsersApi(Dio dio, {String? baseUrl}) = _UsersApi;

  /// FCM 디바이스 토큰 등록/갱신
  /// 로그인 직후 및 토큰 갱신(onTokenRefresh) 발생 시 호출
  ///
  /// Parameters:
  /// * [fcmTokenUpdateRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/users/me/fcm-token')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseVoid> updateFcmToken({
    @Body() required FcmTokenUpdateRequest fcmTokenUpdateRequest,
    CancelToken? cancelToken,
  });

  /// 가입 시 위치 설정 (필수, 최초 1회 / 이후 변경도 가능)
  ///
  ///
  /// Parameters:
  /// * [locationUpdateRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/users/me/location')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseJWTToken> updateLocation({
    @Body() required LocationUpdateRequest locationUpdateRequest,
    CancelToken? cancelToken,
  });

  /// 회원 탈퇴
  ///
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @DELETE('/users/me')
  Future<ApiResponseVoid> withdraw({CancelToken? cancelToken});
}
