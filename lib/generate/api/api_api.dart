//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/auth_login_request.dart';

part 'api_api.g.dart';

@RestApi()
abstract class APIApi {
  factory APIApi(Dio dio, {String? baseUrl}) = _APIApi;

  /// 토큰발급 API
  /// 1 넣어서 사용하시면 됩니다. 실제 users 테이블의 location_id 여부가 토큰의 locationSet 값에 반영됩니다.
  ///
  /// Parameters:
  /// * [userId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/test/test-login')
  Future<Object> testLogin({
    @Query('userId') required int userId,
    CancelToken? cancelToken,
  });

  /// 유저테이블 데이터 삭제 API
  ///
  ///
  /// Parameters:
  /// * [authLoginRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/test/userInfoClean')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> userInfoClean({
    @Body() required AuthLoginRequest authLoginRequest,
    CancelToken? cancelToken,
  });
}
