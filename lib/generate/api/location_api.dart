//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_list_sigungu_response.dart';
import 'package:emotion_map_app/generate/model/api_response_list_string.dart';

part 'location_api.g.dart';

@RestApi()
abstract class LocationApi {
  factory LocationApi(Dio dio, {String? baseUrl}) = _LocationApi;

  /// 시/도 목록 조회
  ///
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/location/sido')
  Future<ApiResponseListString> getSido({CancelToken? cancelToken});

  /// 시/군/구 목록 조회
  ///
  ///
  /// Parameters:
  /// * [siDo]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/location/sigungu')
  Future<ApiResponseListSigunguResponse> getSigungu({
    @Query('siDo') required String siDo,
    CancelToken? cancelToken,
  });
}
