import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/generate/model/notification_response.dart';
import 'package:emotion_map_app/module/notification/widget/notification_tile.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class NotificationView extends HookConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationService = ref.read(notificationServiceProvider);
    final notifications = useState<List<NotificationResponse>>([]);
    final loading = useState(true);

    Future<void> load() async {
      loading.value = true;
      try {
        final result = await notificationService.getNotifications(
          page: 1,
          size: 50,
        );
        notifications.value = result;
      } catch (e) {
        if (context.mounted) {
          showErrorSnackBar(context, e, fallback: '불러오지 못했어요.');
        }
      } finally {
        loading.value = false;
      }
    }

    useEffect(() {
      load();
      return null;
      // ignore: exhaustive_keys
    }, const []);

    void onNotificationTap(NotificationResponse notification) {
      final postId = notification.postId;
      if (postId == null) return;

      // 탭한 항목만 즉시 읽음 표시 (화면에 바로 반영 + 서버에도 기록, 실패해도 이동은 막지 않는다)
      final notificationId = notification.notificationId;
      if (notificationId != null && notification.isRead != true) {
        notifications.value = notifications.value
            .map((n) => n.notificationId == notificationId
                ? n.copyWith(isRead: true)
                : n)
            .toList();
        notificationService.markRead(notificationId).catchError((_) {});
      }

      context.router.push(PostDetailRoute(postId: postId));
    }

    return Scaffold(
      appBar: const EMTopBar(title: '알림'),
      body: loading.value
          ? const EMLoadingIndicator()
          : RefreshIndicator(
              onRefresh: load,
              color: AppColors.accent,
              child: notifications.value.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        const EMHeight(160),
                        Center(
                          child: Text(
                            '아직 알림이 없어요',
                            style: NotoSansKR.medium.set(
                              size: 14,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: notifications.value.length,
                      separatorBuilder: (_, _) => const EMHeight(8),
                      itemBuilder: (context, index) {
                        final notification = notifications.value[index];
                        return NotificationTile(
                          notification: notification,
                          onTap: () => onNotificationTap(notification),
                        );
                      },
                    ),
            ),
    );
  }
}
