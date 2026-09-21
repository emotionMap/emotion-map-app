//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sigungu_response.freezed.dart';
part 'sigungu_response.g.dart';

@freezed
abstract class SigunguResponse with _$SigunguResponse {
  const factory SigunguResponse({
    /// 위치 ID
    @JsonKey(name: r'locationId') int? locationId,

    /// 시/군/구 명
    @JsonKey(name: r'siGunGu') String? siGunGu,
  }) = _SigunguResponse;

  factory SigunguResponse.fromJson(Map<String, dynamic> json) =>
      _$SigunguResponseFromJson(json);
}
