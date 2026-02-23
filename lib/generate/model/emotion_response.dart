//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'emotion_response.freezed.dart';
part 'emotion_response.g.dart';

@freezed
abstract class EmotionResponse with _$EmotionResponse {
  const factory EmotionResponse({
    /// ID
    @JsonKey(name: r'id') String? id,

    /// 이모지 명
    @JsonKey(name: r'name') String? name,

    /// 이모지
    @JsonKey(name: r'emoji') String? emoji,
  }) = _EmotionResponse;

  factory EmotionResponse.fromJson(Map<String, dynamic> json) =>
      _$EmotionResponseFromJson(json);
}
