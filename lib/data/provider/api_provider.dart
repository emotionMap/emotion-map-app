import 'package:emotion_map_app/data/provider/dio_provider.dart';
import 'package:emotion_map_app/generate/api/auth_api.dart';
import 'package:emotion_map_app/generate/api/profile_api.dart';
import 'package:emotion_map_app/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return AuthApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
ProfileApi profileApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return ProfileApi(dio, baseUrl: apiUrl);
}
