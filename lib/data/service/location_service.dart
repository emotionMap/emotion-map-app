import 'package:dio/dio.dart';
import 'package:emotion_map_app/data/service/auth_service.dart';
import 'package:emotion_map_app/generate/api/location_api.dart';
import 'package:emotion_map_app/generate/api/users_api.dart';
import 'package:emotion_map_app/generate/model/location_update_request.dart';
import 'package:emotion_map_app/generate/model/sigungu_response.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';

/// 가입 시 위치 설정 (필수, 최초 1회 / 이후 변경도 가능) - 지금은 이게 유일한 "가입 절차"다.
class LocationService {
  final LocationApi _locationApi;
  final UsersApi _usersApi;
  final AuthService _authService;

  LocationService(this._locationApi, this._usersApi, this._authService);

  Future<List<String>> getSidoList() async {
    try {
      final response = await _locationApi.getSido();
      return response.data ?? [];
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<List<SigunguResponse>> getSigunguList(String siDo) async {
    try {
      final response = await _locationApi.getSigungu(siDo: siDo);
      return response.data ?? [];
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  /// 위치 설정 - 성공 시 locationSet=true가 반영된 새 토큰을 받아 저장한다.
  Future<void> setLocation(int locationId) async {
    try {
      final response = await _usersApi.updateLocation(
        locationUpdateRequest: LocationUpdateRequest(locationId: locationId),
      );
      final token = response.data;
      if (token != null) {
        await _authService.saveTokens(token);
      }
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
