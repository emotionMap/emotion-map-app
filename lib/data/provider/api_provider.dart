import 'package:emotion_map_app/data/provider/dio_provider.dart';
import 'package:emotion_map_app/generate/api/auth_api.dart';
import 'package:emotion_map_app/generate/api/comments_api.dart';
import 'package:emotion_map_app/generate/api/emotion_api.dart';
import 'package:emotion_map_app/generate/api/location_api.dart';
import 'package:emotion_map_app/generate/api/map_api.dart';
import 'package:emotion_map_app/generate/api/posts_api.dart';
import 'package:emotion_map_app/generate/api/users_api.dart';
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
UsersApi usersApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return UsersApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
LocationApi locationApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return LocationApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
PostsApi postsApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return PostsApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
CommentsApi commentsApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return CommentsApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
MapApi mapApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return MapApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
EmotionApi emotionApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return EmotionApi(dio, baseUrl: apiUrl);
}
