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
    /// 클라이언트가 기기별로 생성해 보관하는 익명 식별자
    @JsonKey(name: r'deviceId') String? deviceId,
  }) = _AuthLoginRequest;

  factory AuthLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginRequestFromJson(json);
}
