//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_update_request.freezed.dart';
part 'post_update_request.g.dart';

@freezed
abstract class PostUpdateRequest with _$PostUpdateRequest {
  const factory PostUpdateRequest({
    /// 소셜 로그인 제공자
    @JsonKey(name: r'provider') String? provider,
  }) = _PostUpdateRequest;

  factory PostUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$PostUpdateRequestFromJson(json);
}
