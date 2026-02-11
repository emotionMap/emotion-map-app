//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/post_list_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_post_list_response.freezed.dart';
part 'api_response_post_list_response.g.dart';

@freezed
abstract class ApiResponsePostListResponse with _$ApiResponsePostListResponse {
  const factory ApiResponsePostListResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') PostListResponse? data,
  }) = _ApiResponsePostListResponse;

  factory ApiResponsePostListResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponsePostListResponseFromJson(json);
}
