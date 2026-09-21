//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_list_map_region_response.dart';

part 'map_api.g.dart';

@RestApi()
abstract class MapApi {
  factory MapApi(Dio dio, {String? baseUrl}) = _MapApi;

  /// 지역별 지도 요약
  /// 지역(시/군/구)별로 최근 부착된 감정 태그 최대 5개. 게시글이 없는 지역은 제외됨
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/map')
  Future<ApiResponseListMapRegionResponse> getRegionSummaries({
    CancelToken? cancelToken,
  });
}
