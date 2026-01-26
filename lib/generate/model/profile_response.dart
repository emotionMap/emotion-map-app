//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/jwt_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
abstract class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    /// 사용자 상태
    @JsonKey(name: r'status') ProfileResponseStatusEnum? status,

    /// JWT 토큰
    @JsonKey(name: r'token') JWTToken? token,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}

/// 사용자 상태
enum ProfileResponseStatusEnum {
  /// 사용자 상태
  @JsonValue(r'REGISTERED')
  registered(r'REGISTERED'),

  /// 사용자 상태
  @JsonValue(r'UNREGISTERED')
  unregistered(r'UNREGISTERED');

  const ProfileResponseStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
