//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_list_string.freezed.dart';
part 'api_response_list_string.g.dart';

@freezed
abstract class ApiResponseListString with _$ApiResponseListString {
  const factory ApiResponseListString({
    /// 응답 데이터
    @JsonKey(name: r'data') List<String>? data,
  }) = _ApiResponseListString;

  factory ApiResponseListString.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseListStringFromJson(json);
}
