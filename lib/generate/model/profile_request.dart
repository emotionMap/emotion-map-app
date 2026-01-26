//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_request.freezed.dart';
part 'profile_request.g.dart';

@freezed
abstract class ProfileRequest with _$ProfileRequest {
  const factory ProfileRequest({
    /// 소셜 제공자
    @JsonKey(name: r'provider') String? provider,

    /// 소셜 사용자 ID
    @JsonKey(name: r'providerUserId') String? providerUserId,

    /// 닉네임
    @JsonKey(name: r'nickname') String? nickname,

    /// 소개글
    @JsonKey(name: r'bio') String? bio,

    /// 이미지 URL
    @JsonKey(name: r'profile_image_url') String? profileImageUrl,
  }) = _ProfileRequest;

  factory ProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileRequestFromJson(json);
}
