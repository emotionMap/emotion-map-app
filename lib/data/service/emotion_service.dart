import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/emotion_api.dart';
import 'package:emotion_map_app/generate/model/emotion_response.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';

class EmotionService {
  final EmotionApi _emotionApi;

  EmotionService(this._emotionApi);

  Future<List<EmotionResponse>> getEmotions() async {
    try {
      final response = await _emotionApi.getEmotion();
      return response.data ?? [];
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
