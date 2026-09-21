//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/emotion.dart';
import 'package:emotion_map_app/generate/model/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    /// 포스트 아이디
    @JsonKey(name: r'postId') int? postId,

    /// 이 스레드 내에서 부여된 익명 닉네임
    @JsonKey(name: r'nickname') String? nickname,

    /// 위치 아이디
    @JsonKey(name: r'locationId') int? locationId,

    /// 시/도
    @JsonKey(name: r'siDo') String? siDo,

    /// 시/군/구
    @JsonKey(name: r'siGunGu') String? siGunGu,

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

    /// 상태
    @JsonKey(name: r'status') PostStatusEnum? status,

    /// 포스트 사진
    @JsonKey(name: r'imageList') List<Image>? imageList,

    /// 포스트 감정
    @JsonKey(name: r'emotionList') List<Emotion>? emotionList,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

/// 상태
enum PostStatusEnum {
  /// 상태
  @JsonValue(r'ACTIVE')
  active(r'ACTIVE'),

  /// 상태
  @JsonValue(r'DELETED')
  deleted(r'DELETED');

  const PostStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
