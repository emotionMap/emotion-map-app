//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_detail_response.freezed.dart';
part 'post_detail_response.g.dart';

@freezed
abstract class PostDetailResponse with _$PostDetailResponse {
  const factory PostDetailResponse({
    /// 소셜 로그인 제공자
    @JsonKey(name: r'provider') String? provider,
  }) = _PostDetailResponse;

  factory PostDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PostDetailResponseFromJson(json);
}
