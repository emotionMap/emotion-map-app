//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/post_detail_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_post_detail_response.freezed.dart';
part 'api_response_post_detail_response.g.dart';

@freezed
abstract class ApiResponsePostDetailResponse
    with _$ApiResponsePostDetailResponse {
  const factory ApiResponsePostDetailResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') PostDetailResponse? data,
  }) = _ApiResponsePostDetailResponse;

  factory ApiResponsePostDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponsePostDetailResponseFromJson(json);
}
