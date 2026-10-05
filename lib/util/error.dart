import 'package:dio/dio.dart';
import 'package:emotion_map_app/model/error_response.dart';
import 'package:flutter/material.dart';

/// 사용자에게 보여줄 에러 문구를 돌려준다. 백엔드 [ErrorResponse.error.message]가 있으면
/// 그대로 쓰고, 없으면 각 화면이 [ErrorMessage.isFallback]로 자체 안내 문구를 대신 쓸 수 있게
/// 빈 문자열을 돌려준다 - 디버그 코드(POST_NOT_FOUND 등)를 사용자에게 노출하지 않는다.
String getErrorMessage(DioException e) {
  if (e.type == DioExceptionType.cancel) {
    debugPrint("$e");
    return "";
  }
  final errorResponseData = e.response?.data;

  if (errorResponseData != null) {
    try {
      final response = ErrorResponse.fromJson(errorResponseData);
      return response.error.message;
    } catch (e) {
      debugPrint("$e");
      return "";
    }
  } else {
    debugPrint("$e");
    return "";
  }
}
