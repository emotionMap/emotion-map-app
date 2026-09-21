//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:emotion_map_app/generate/model/emotion.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_region_response.freezed.dart';
part 'map_region_response.g.dart';

@freezed
abstract class MapRegionResponse with _$MapRegionResponse {
  const factory MapRegionResponse({
    /// 위치 아이디
    @JsonKey(name: r'locationId') int? locationId,

    /// 시/도
    @JsonKey(name: r'siDo') String? siDo,

    /// 시/군/구
    @JsonKey(name: r'siGunGu') String? siGunGu,

    /// 이 지역에 최근 부착된 감정 태그 최대 5개 (게시글 작성 시각 기준 최신순, 같은 게시글에서 여러 개 나올 수 있음)
    @JsonKey(name: r'recentEmotions') List<Emotion>? recentEmotions,
  }) = _MapRegionResponse;

  factory MapRegionResponse.fromJson(Map<String, dynamic> json) =>
      _$MapRegionResponseFromJson(json);
}
