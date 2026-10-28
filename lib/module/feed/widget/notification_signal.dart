import 'package:flutter/foundation.dart';

/// FCM 포그라운드 메시지를 수신하면 값이 증가한다.
/// [NotificationBellButton]이 구독해서 즉시 안읽은 알림 개수를 다시 불러온다.
final notificationsChangedSignal = ValueNotifier<int>(0);
