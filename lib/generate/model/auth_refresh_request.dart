//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_refresh_request.freezed.dart';
part 'auth_refresh_request.g.dart';

@freezed
abstract class AuthRefreshRequest with _$AuthRefreshRequest {
  const factory AuthRefreshRequest({
    /// Refresh Token
    @JsonKey(name: r'refreshToken') String? refreshToken,
  }) = _AuthRefreshRequest;

  factory AuthRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRefreshRequestFromJson(json);
}
