//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_request.freezed.dart';
part 'auth_login_request.g.dart';

@freezed
abstract class AuthLoginRequest with _$AuthLoginRequest {
  const factory AuthLoginRequest({
    /// 소셜 로그인 제공자
    @JsonKey(name: r'provider') AuthLoginRequestProviderEnum? provider,

    /// 소셜 Access Token
    @JsonKey(name: r'accessToken') String? accessToken,
  }) = _AuthLoginRequest;

  factory AuthLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginRequestFromJson(json);
}

/// 소셜 로그인 제공자
enum AuthLoginRequestProviderEnum {
  /// 소셜 로그인 제공자
  @JsonValue(r'KAKAO')
  kakao(r'KAKAO'),

  /// 소셜 로그인 제공자
  @JsonValue(r'NAVER')
  naver(r'NAVER'),

  /// 소셜 로그인 제공자
  @JsonValue(r'APPLE')
  apple(r'APPLE');

  const AuthLoginRequestProviderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
