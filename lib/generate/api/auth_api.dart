//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_auth_login_response.dart';
import 'package:emotion_map_app/generate/model/auth_login_request.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  /// 소셜 로그인
  /// 카카오 / 네이버 소셜 로그인 API
  ///
  /// Parameters:
  /// * [authLoginRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/login')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseAuthLoginResponse> login1({
    @Body() required AuthLoginRequest authLoginRequest,
    CancelToken? cancelToken,
  });
}
