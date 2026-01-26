//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jwt_token.freezed.dart';
part 'jwt_token.g.dart';

@freezed
abstract class JWTToken with _$JWTToken {
  const factory JWTToken({
    @JsonKey(name: r'accessToken') String? accessToken,
    @JsonKey(name: r'refreshToken') String? refreshToken,
  }) = _JWTToken;

  factory JWTToken.fromJson(Map<String, dynamic> json) =>
      _$JWTTokenFromJson(json);
}
