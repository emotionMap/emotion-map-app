//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_update_request.freezed.dart';
part 'post_update_request.g.dart';

@freezed
abstract class PostUpdateRequest with _$PostUpdateRequest {
  const factory PostUpdateRequest({
    /// 위치 ID (선택)
    @JsonKey(name: r'locationId') int? locationId,

    /// 감정 태그 ID 목록 (선택, 전달 시 전체 교체)
    @JsonKey(name: r'emotionIds') List<int>? emotionIds,

    /// 본문 (선택)
    @JsonKey(name: r'content') String? content,
    @JsonKey(name: r'postId') int? postId,
  }) = _PostUpdateRequest;

  factory PostUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$PostUpdateRequestFromJson(json);
}
