//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/notification_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_list_notification_response.freezed.dart';
part 'api_response_list_notification_response.g.dart';

@freezed
abstract class ApiResponseListNotificationResponse
    with _$ApiResponseListNotificationResponse {
  const factory ApiResponseListNotificationResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') List<NotificationResponse>? data,
  }) = _ApiResponseListNotificationResponse;

  factory ApiResponseListNotificationResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ApiResponseListNotificationResponseFromJson(json);
}
