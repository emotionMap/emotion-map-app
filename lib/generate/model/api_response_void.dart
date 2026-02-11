//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_void.freezed.dart';
part 'api_response_void.g.dart';

@freezed
abstract class ApiResponseVoid with _$ApiResponseVoid {
  const factory ApiResponseVoid({
    /// 응답 데이터
    @JsonKey(name: r'data') Object? data,
  }) = _ApiResponseVoid;

  factory ApiResponseVoid.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseVoidFromJson(json);
}
