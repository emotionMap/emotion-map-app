//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_response.freezed.dart';
part 'auth_login_response.g.dart';

@freezed
abstract class AuthLoginResponse with _$AuthLoginResponse {
  const factory AuthLoginResponse({
    /// 소셜 제공자
    @JsonKey(name: r'provider') String? provider,

    /// 소셜 사용자 ID
    @JsonKey(name: r'providerUserId') String? providerUserId,

    /// 사용자 상태
    @JsonKey(name: r'status') AuthLoginResponseStatusEnum? status,
  }) = _AuthLoginResponse;

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseFromJson(json);
}

/// 사용자 상태
enum AuthLoginResponseStatusEnum {
  /// 사용자 상태
  @JsonValue(r'REGISTERED')
  registered(r'REGISTERED'),

  /// 사용자 상태
  @JsonValue(r'UNREGISTERED')
  unregistered(r'UNREGISTERED');

  const AuthLoginResponseStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
