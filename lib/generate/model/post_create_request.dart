//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_create_request.freezed.dart';
part 'post_create_request.g.dart';

@freezed
abstract class PostCreateRequest with _$PostCreateRequest {
  const factory PostCreateRequest({
    /// 소셜 로그인 제공자
    @JsonKey(name: r'provider') String? provider,
  }) = _PostCreateRequest;

  factory PostCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PostCreateRequestFromJson(json);
}
