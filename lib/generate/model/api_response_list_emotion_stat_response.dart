//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/emotion_stat_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_list_emotion_stat_response.freezed.dart';
part 'api_response_list_emotion_stat_response.g.dart';

@freezed
abstract class ApiResponseListEmotionStatResponse
    with _$ApiResponseListEmotionStatResponse {
  const factory ApiResponseListEmotionStatResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') List<EmotionStatResponse>? data,
  }) = _ApiResponseListEmotionStatResponse;

  factory ApiResponseListEmotionStatResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ApiResponseListEmotionStatResponseFromJson(json);
}
