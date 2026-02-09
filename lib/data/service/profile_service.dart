import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/profile_api.dart';
import 'package:emotion_map_app/generate/model/api_response_profile_response.dart';
import 'package:emotion_map_app/generate/model/profile_request.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ProfileService {
  // ignore: unused_field
  final Ref _ref;
  final ProfileApi _profileApi;

  ProfileService(this._ref, this._profileApi);

  Future<ApiResponseProfileResponse> register({
    required String type,
    required String socialId,
    required String nickname,
    required String bio,
    required String image,
  }) async {
    try {
      return await _profileApi.login(
        profileRequest: ProfileRequest(
          provider: type,
          providerUserId: socialId,
          nickname: nickname,
          bio: bio,
          profileImageUrl: image,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
