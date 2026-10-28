//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_integer.freezed.dart';
part 'api_response_integer.g.dart';

@freezed
abstract class ApiResponseInteger with _$ApiResponseInteger {
  const factory ApiResponseInteger({
    /// 응답 데이터
    @JsonKey(name: r'data') int? data,
  }) = _ApiResponseInteger;

  factory ApiResponseInteger.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseIntegerFromJson(json);
}
