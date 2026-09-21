//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_update_request.freezed.dart';
part 'comment_update_request.g.dart';

@freezed
abstract class CommentUpdateRequest with _$CommentUpdateRequest {
  const factory CommentUpdateRequest({
    /// 내용
    @JsonKey(name: r'content') required String content,
    @JsonKey(name: r'commentId') int? commentId,
  }) = _CommentUpdateRequest;

  factory CommentUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CommentUpdateRequestFromJson(json);
}
