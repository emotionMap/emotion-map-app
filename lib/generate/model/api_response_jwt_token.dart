//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/jwt_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_jwt_token.freezed.dart';
part 'api_response_jwt_token.g.dart';

@freezed
abstract class ApiResponseJWTToken with _$ApiResponseJWTToken {
  const factory ApiResponseJWTToken({
    /// 응답 데이터
    @JsonKey(name: r'data') JWTToken? data,
  }) = _ApiResponseJWTToken;

  factory ApiResponseJWTToken.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseJWTTokenFromJson(json);
}
