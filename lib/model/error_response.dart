import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';
part 'error_response.g.dart';

@freezed
abstract class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({required ErrorData error}) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}

@freezed
abstract class ErrorData with _$ErrorData {
  const factory ErrorData({required String code, required String message}) =
      _ErrorData;

  factory ErrorData.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataFromJson(json);
}
