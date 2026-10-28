//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_response.freezed.dart';
part 'notification_response.g.dart';

@freezed
abstract class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    /// 알림 아이디
    @JsonKey(name: r'notificationId') int? notificationId,

    /// 알림 종류
    @JsonKey(name: r'type') NotificationResponseTypeEnum? type,

    /// 대상 게시글 아이디
    @JsonKey(name: r'postId') int? postId,

    /// 대상 댓글 아이디 (LIKE는 없음)
    @JsonKey(name: r'commentId') int? commentId,

    /// 알림 문구
    @JsonKey(name: r'message') String? message,

    /// 읽음 여부
    @JsonKey(name: r'isRead') bool? isRead,

    /// 생성시간
    @JsonKey(name: r'createdAt') String? createdAt,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

/// 알림 종류
enum NotificationResponseTypeEnum {
  /// 알림 종류
  @JsonValue(r'LIKE')
  like(r'LIKE'),

  /// 알림 종류
  @JsonValue(r'COMMENT')
  comment(r'COMMENT'),

  /// 알림 종류
  @JsonValue(r'REPLY')
  reply(r'REPLY');

  const NotificationResponseTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
