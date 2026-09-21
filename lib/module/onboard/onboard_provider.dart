import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 익명 로그인 (deviceId 기반, 본인인증 없음) - 성공하면 locationSet 여부를 반환한다.
Future<bool> startAnonymousLogin(WidgetRef ref) async {
  final context = ref.context;
  context.loaderOverlay.show();

  try {
    final authService = ref.read(authServiceProvider);
    final response = await authService.login();

    return response.locationSet ?? false;
  } finally {
    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }
}
