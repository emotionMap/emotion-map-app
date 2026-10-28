import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/module/feed/widget/notification_signal.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 피드 상단바 우측 알림 벨 - 안읽은 알림이 있으면 점으로 표시되고,
/// 알림 목록 화면에서 전체 읍음 처리 후 돌아오면 점이 사라진다.
class NotificationBellButton extends HookConsumerWidget {
  const NotificationBellButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationService = ref.read(notificationServiceProvider);
    final unreadCount = useState(0);

    Future<void> refresh() async {
      try {
        unreadCount.value = await notificationService.getUnreadCount();
      } catch (_) {
        // 뱃지는 부가 정보라 실패해도 화면을 막지 않는다.
      }
    }

    useEffect(() {
      refresh();
      return null;
      // ignore: exhaustive_keys
    }, const []);

    useEffect(() {
      void onSignal() => refresh();
      notificationsChangedSignal.addListener(onSignal);
      return () => notificationsChangedSignal.removeListener(onSignal);
      // ignore: exhaustive_keys
    }, const []);

    Future<void> onTap() async {
      await context.router.push(const NotificationRoute());
      await refresh();
    }

    final hasUnread = unreadCount.value > 0;

    return IconButton(
      onPressed: onTap,
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.notifications_outlined),
          if (hasUnread)
            Positioned(
              top: -1,
              right: -1,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.notificationDot,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
