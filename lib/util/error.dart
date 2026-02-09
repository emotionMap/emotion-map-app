import 'package:dio/dio.dart';
import 'package:emotion_map_app/model/error_response.dart';
import 'package:flutter/material.dart';

String getErrorMessage(DioException e) {
  if (e.type == DioExceptionType.cancel) {
    debugPrint("$e");
    return "cancel";
  }
  final errorResponseData = e.response?.data;

  if (errorResponseData != null) {
    try {
      final response = ErrorResponse.fromJson(errorResponseData);
      debugPrint(response.error.message);
      return response.error.code;
    } catch (e) {
      debugPrint("$e");
      return "error";
    }
  } else {
    debugPrint("$e");
    return "error";
  }
}
