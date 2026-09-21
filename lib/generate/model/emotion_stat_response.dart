//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'emotion_stat_response.freezed.dart';
part 'emotion_stat_response.g.dart';

@freezed
abstract class EmotionStatResponse with _$EmotionStatResponse {
  const factory EmotionStatResponse({
    /// 감정 아이디
    @JsonKey(name: r'id') int? id,

    /// 감정 이름
    @JsonKey(name: r'name') String? name,

    /// 감정 이모지
    @JsonKey(name: r'emoji') String? emoji,

    /// 기간 내 사용 횟수
    @JsonKey(name: r'count') int? count,
  }) = _EmotionStatResponse;

  factory EmotionStatResponse.fromJson(Map<String, dynamic> json) =>
      _$EmotionStatResponseFromJson(json);
}
