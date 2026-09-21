import 'package:emotion_map_app/data/provider/api_provider.dart';
import 'package:emotion_map_app/data/service/auth_service.dart';
import 'package:emotion_map_app/data/service/comments_service.dart';
import 'package:emotion_map_app/data/service/emotion_service.dart';
import 'package:emotion_map_app/data/service/location_service.dart';
import 'package:emotion_map_app/data/service/map_service.dart';
import 'package:emotion_map_app/data/service/posts_service.dart';
import 'package:emotion_map_app/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final api = ref.watch(authApiProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return AuthService(ref, api, secureStorage);
}

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) {
  final locationApi = ref.watch(locationApiProvider);
  final usersApi = ref.watch(usersApiProvider);
  final authService = ref.watch(authServiceProvider);

  return LocationService(locationApi, usersApi, authService);
}

@Riverpod(keepAlive: true)
PostsService postsService(Ref ref) {
  final api = ref.watch(postsApiProvider);

  return PostsService(api);
}

@Riverpod(keepAlive: true)
CommentsService commentsService(Ref ref) {
  final api = ref.watch(commentsApiProvider);

  return CommentsService(api);
}

@Riverpod(keepAlive: true)
MapService mapService(Ref ref) {
  final api = ref.watch(mapApiProvider);

  return MapService(api);
}

@Riverpod(keepAlive: true)
EmotionService emotionService(Ref ref) {
  final api = ref.watch(emotionApiProvider);

  return EmotionService(api);
}
