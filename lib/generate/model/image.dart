//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
abstract class Image with _$Image {
  const factory Image({
    /// 포스트 ID
    @JsonKey(name: r'postId') int? postId,

    /// 이미지 URL
    @JsonKey(name: r'url') String? url,

    /// 노출 순서
    @JsonKey(name: r'sortOrder') int? sortOrder,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
