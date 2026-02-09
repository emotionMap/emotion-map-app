import 'package:emotion_map_app/data/provider/api_provider.dart';
import 'package:emotion_map_app/data/service/auth_service.dart';
import 'package:emotion_map_app/data/service/profile_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final api = ref.watch(authApiProvider);

  return AuthService(ref, api);
}

@Riverpod(keepAlive: true)
ProfileService profileService(Ref ref) {
  final api = ref.watch(profileApiProvider);

  return ProfileService(ref, api);
}
