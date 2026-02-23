//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/emotion.dart';
import 'package:emotion_map_app/generate/model/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_list_response.freezed.dart';
part 'post_list_response.g.dart';

@freezed
abstract class PostListResponse with _$PostListResponse {
  const factory PostListResponse({
    /// 포스트 아이디
    @JsonKey(name: r'postId') int? postId,

    /// 유저 아이디
    @JsonKey(name: r'userId') int? userId,

    /// 닉네임
    @JsonKey(name: r'nickname') String? nickname,

    /// 작성자 프로필 이미지 URL
    @JsonKey(name: r'profileImageUrl') String? profileImageUrl,

    /// 위치 아이디
    @JsonKey(name: r'locationId') int? locationId,

    /// 위치
    @JsonKey(name: r'locationName') String? locationName,

    /// 내용
    @JsonKey(name: r'content') String? content,

    /// 작성시간
    @JsonKey(name: r'createdAt') String? createdAt,

    /// 좋아요 표시 여부
    @JsonKey(name: r'likeYN') String? likeYN,

    /// 좋아요 개수
    @JsonKey(name: r'likeCount') int? likeCount,

    /// 댓글 개수
    @JsonKey(name: r'commentCount') int? commentCount,

    /// 내가 작성한 글인지 여부
    @JsonKey(name: r'isMine') bool? isMine,

    /// 포스트 사진
    @JsonKey(name: r'imageList') List<Image>? imageList,

    /// 포스트 감정
    @JsonKey(name: r'emotionList') List<Emotion>? emotionList,
  }) = _PostListResponse;

  factory PostListResponse.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseFromJson(json);
}
