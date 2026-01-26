//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/auth_login_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_auth_login_response.freezed.dart';
part 'api_response_auth_login_response.g.dart';

@freezed
abstract class ApiResponseAuthLoginResponse
    with _$ApiResponseAuthLoginResponse {
  const factory ApiResponseAuthLoginResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') AuthLoginResponse? data,
  }) = _ApiResponseAuthLoginResponse;

  factory ApiResponseAuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseAuthLoginResponseFromJson(json);
}
