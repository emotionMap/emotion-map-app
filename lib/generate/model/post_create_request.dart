//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_create_request.freezed.dart';
part 'post_create_request.g.dart';

@freezed
abstract class PostCreateRequest with _$PostCreateRequest {
  const factory PostCreateRequest({
    /// 위치 ID
    @JsonKey(name: r'locationId') required int locationId,

    /// 감정 태그 ID 목록
    @JsonKey(name: r'emotionIds') required List<int> emotionIds,

    /// 본문 (선택)
    @JsonKey(name: r'content') String? content,
    @JsonKey(name: r'userId') int? userId,
    @JsonKey(name: r'postId') int? postId,
  }) = _PostCreateRequest;

  factory PostCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PostCreateRequestFromJson(json);
}
