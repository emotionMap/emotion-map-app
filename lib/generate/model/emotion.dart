//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'emotion.freezed.dart';
part 'emotion.g.dart';

@freezed
abstract class Emotion with _$Emotion {
  const factory Emotion({
    /// 포스트 ID
    @JsonKey(name: r'postId') int? postId,

    /// 감정 아이디
    @JsonKey(name: r'id') int? id,

    /// 감정 이모지
    @JsonKey(name: r'emoji') String? emoji,

    /// 감정 이름
    @JsonKey(name: r'name') String? name,
  }) = _Emotion;

  factory Emotion.fromJson(Map<String, dynamic> json) =>
      _$EmotionFromJson(json);
}
