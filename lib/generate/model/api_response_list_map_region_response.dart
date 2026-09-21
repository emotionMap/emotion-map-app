//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/map_region_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_list_map_region_response.freezed.dart';
part 'api_response_list_map_region_response.g.dart';

@freezed
abstract class ApiResponseListMapRegionResponse
    with _$ApiResponseListMapRegionResponse {
  const factory ApiResponseListMapRegionResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') List<MapRegionResponse>? data,
  }) = _ApiResponseListMapRegionResponse;

  factory ApiResponseListMapRegionResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ApiResponseListMapRegionResponseFromJson(json);
}
