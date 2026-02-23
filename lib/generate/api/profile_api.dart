//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_profile_response.dart';
import 'package:emotion_map_app/generate/model/profile_request.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String? baseUrl}) = _ProfileApi;

  /// 회원가입(프로필 등록)
  ///
  ///
  /// Parameters:
  /// * [profileRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/profile/create')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseProfileResponse> login({
    @Body() required ProfileRequest profileRequest,
    CancelToken? cancelToken,
  });
}
