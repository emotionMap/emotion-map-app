//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_string.freezed.dart';
part 'api_response_string.g.dart';

@freezed
abstract class ApiResponseString with _$ApiResponseString {
  const factory ApiResponseString({
    /// 응답 데이터
    @JsonKey(name: r'data') String? data,
  }) = _ApiResponseString;

  factory ApiResponseString.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseStringFromJson(json);
}
