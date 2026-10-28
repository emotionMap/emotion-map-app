import 'package:emotion_map_app/generate/model/notification_response.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/util/time_format.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final NotificationResponse notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unread = notification.isRead != true;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: AppDecorations.card(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: unread ? AppColors.notificationDot : Colors.transparent,
              ),
            ),
            const EMWidth(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.message ?? '',
                    style: NotoSansKR.medium.set(
                      size: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const EMHeight(4),
                  Text(
                    displayTime(notification.createdAt),
                    style: NotoSansKR.regular.set(
                      size: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
