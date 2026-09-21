//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_update_request.freezed.dart';
part 'location_update_request.g.dart';

@freezed
abstract class LocationUpdateRequest with _$LocationUpdateRequest {
  const factory LocationUpdateRequest({
    /// 위치 ID (locations.id)
    @JsonKey(name: r'locationId') required int locationId,
  }) = _LocationUpdateRequest;

  factory LocationUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$LocationUpdateRequestFromJson(json);
}
