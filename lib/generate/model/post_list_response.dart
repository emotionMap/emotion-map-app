//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_list_response.freezed.dart';
part 'post_list_response.g.dart';

@freezed
abstract class PostListResponse with _$PostListResponse {
  const factory PostListResponse({
    /// 소셜 로그인 제공자
    @JsonKey(name: r'provider') String? provider,
  }) = _PostListResponse;

  factory PostListResponse.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseFromJson(json);
}
