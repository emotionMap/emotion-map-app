//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token_update_request.freezed.dart';
part 'fcm_token_update_request.g.dart';

@freezed
abstract class FcmTokenUpdateRequest with _$FcmTokenUpdateRequest {
  const factory FcmTokenUpdateRequest({
    /// FCM 디바이스 토큰
    @JsonKey(name: r'fcmToken') required String fcmToken,
  }) = _FcmTokenUpdateRequest;

  factory FcmTokenUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$FcmTokenUpdateRequestFromJson(json);
}
