//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_create_request.freezed.dart';
part 'comment_create_request.g.dart';

@freezed
abstract class CommentCreateRequest with _$CommentCreateRequest {
  const factory CommentCreateRequest({
    /// 내용
    @JsonKey(name: r'content') required String content,

    /// 부모 댓글 ID (대댓글 작성 시, 없으면 게시글에 바로 다는 최상위 댓글)
    @JsonKey(name: r'parentCommentId') int? parentCommentId,
    @JsonKey(name: r'postId') int? postId,
    @JsonKey(name: r'userId') int? userId,
    @JsonKey(name: r'commentId') int? commentId,
  }) = _CommentCreateRequest;

  factory CommentCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$CommentCreateRequestFromJson(json);
}
