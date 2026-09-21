//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_long.freezed.dart';
part 'api_response_long.g.dart';

@freezed
abstract class ApiResponseLong with _$ApiResponseLong {
  const factory ApiResponseLong({
    /// 응답 데이터
    @JsonKey(name: r'data') int? data,
  }) = _ApiResponseLong;

  factory ApiResponseLong.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseLongFromJson(json);
}
