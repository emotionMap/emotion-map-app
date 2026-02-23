//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_list_emotion_response.dart';

part 'emotion_api.g.dart';

@RestApi()
abstract class EmotionApi {
  factory EmotionApi(Dio dio, {String? baseUrl}) = _EmotionApi;

  /// 감정리스트 조회
  ///
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/emotion')
  Future<ApiResponseListEmotionResponse> getEmotion({CancelToken? cancelToken});
}
