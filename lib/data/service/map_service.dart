import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/map_api.dart';
import 'package:emotion_map_app/generate/model/map_region_response.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';

class MapService {
  final MapApi _mapApi;

  MapService(this._mapApi);

  Future<List<MapRegionResponse>> getRegionSummaries() async {
    try {
      final response = await _mapApi.getRegionSummaries();
      return response.data ?? [];
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
