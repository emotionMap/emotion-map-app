//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/jwt_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_response.freezed.dart';
part 'auth_login_response.g.dart';

@freezed
abstract class AuthLoginResponse with _$AuthLoginResponse {
  const factory AuthLoginResponse({
    /// 위치 설정 완료 여부 - false면 /users/me/location 호출 전까지 다른 API 사용 불가
    @JsonKey(name: r'locationSet') bool? locationSet,

    /// JWT 토큰
    @JsonKey(name: r'token') JWTToken? token,
  }) = _AuthLoginResponse;

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseFromJson(json);
}
