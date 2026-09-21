//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_response.freezed.dart';
part 'comment_response.g.dart';

@freezed
abstract class CommentResponse with _$CommentResponse {
  const factory CommentResponse({
    /// 댓글 아이디
    @JsonKey(name: r'commentId') int? commentId,

    /// 이 게시글 내에서 부여된 익명 닉네임
    @JsonKey(name: r'nickname') String? nickname,

    /// 내용
    @JsonKey(name: r'content') String? content,

    /// 작성시간
    @JsonKey(name: r'createdAt') String? createdAt,

    /// 내가 작성한 댓글인지 여부
    @JsonKey(name: r'isMine') bool? isMine,

    /// 상태
    @JsonKey(name: r'status') CommentResponseStatusEnum? status,
    @JsonKey(name: r'children') Object? children,
  }) = _CommentResponse;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);
}

/// 상태
enum CommentResponseStatusEnum {
  /// 상태
  @JsonValue(r'ACTIVE')
  active(r'ACTIVE'),

  /// 상태
  @JsonValue(r'DELETED')
  deleted(r'DELETED');

  const CommentResponseStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
