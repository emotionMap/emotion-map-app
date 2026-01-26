//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_profile_response.freezed.dart';
part 'api_response_profile_response.g.dart';

@freezed
abstract class ApiResponseProfileResponse with _$ApiResponseProfileResponse {
  const factory ApiResponseProfileResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') ProfileResponse? data,
  }) = _ApiResponseProfileResponse;

  factory ApiResponseProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseProfileResponseFromJson(json);
}
