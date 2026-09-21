//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/post.dart';
import 'package:emotion_map_app/generate/model/comment_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_detail_response.freezed.dart';
part 'post_detail_response.g.dart';

@freezed
abstract class PostDetailResponse with _$PostDetailResponse {
  const factory PostDetailResponse({
    /// 현재 포스트 정보
    @JsonKey(name: r'post') Post? post,

    /// 댓글 목록 (대댓글까지 중첩 트리로 포함)
    @JsonKey(name: r'comments') List<CommentResponse>? comments,
  }) = _PostDetailResponse;

  factory PostDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PostDetailResponseFromJson(json);
}
