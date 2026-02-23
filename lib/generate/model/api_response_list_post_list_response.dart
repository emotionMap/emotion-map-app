//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/post_list_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_list_post_list_response.freezed.dart';
part 'api_response_list_post_list_response.g.dart';

@freezed
abstract class ApiResponseListPostListResponse
    with _$ApiResponseListPostListResponse {
  const factory ApiResponseListPostListResponse({
    /// 응답 데이터
    @JsonKey(name: r'data') List<PostListResponse>? data,
  }) = _ApiResponseListPostListResponse;

  factory ApiResponseListPostListResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseListPostListResponseFromJson(json);
}
