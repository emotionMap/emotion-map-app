//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/emotion_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_list_emotion_response.freezed.dart';
part 'api_response_list_emotion_response.g.dart';

@freezed
abstract class ApiResponseListEmotionResponse
    with _$ApiResponseListEmotionResponse {
  const factory ApiResponseListEmotionResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') List<EmotionResponse>? data,
  }) = _ApiResponseListEmotionResponse;

  factory ApiResponseListEmotionResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseListEmotionResponseFromJson(json);
}
