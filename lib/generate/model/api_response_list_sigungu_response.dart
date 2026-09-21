//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/sigungu_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_list_sigungu_response.freezed.dart';
part 'api_response_list_sigungu_response.g.dart';

@freezed
abstract class ApiResponseListSigunguResponse
    with _$ApiResponseListSigunguResponse {
  const factory ApiResponseListSigunguResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') List<SigunguResponse>? data,
  }) = _ApiResponseListSigunguResponse;

  factory ApiResponseListSigunguResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseListSigunguResponseFromJson(json);
}
