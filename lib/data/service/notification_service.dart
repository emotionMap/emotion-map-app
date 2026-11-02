import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/notifications_api.dart';
import 'package:emotion_map_app/generate/model/notification_response.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  final NotificationsApi _notificationsApi;

  NotificationService(this._notificationsApi);

  /// 피드 상단 알림 뱃지 활성/비활성 판단용 (0이면 비활성)
  Future<int> getUnreadCount() async {
    try {
      final response = await _notificationsApi.getUnreadCount();
      return response.data ?? 0;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("");
    }
  }

  Future<List<NotificationResponse>> getNotifications({
    required int page,
    int size = 20,
  }) async {
    try {
      final response = await _notificationsApi.getNotifications(
        page: page,
        size: size,
      );
      return response.data ?? [];
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("");
    }
  }

  /// 전체 읽음 처리
  Future<void> readAll() async {
    try {
      await _notificationsApi.readAll();
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("");
    }
  }

  /// 개별 알림 읽음 처리 - 알림 목록에서 항목을 탭했을 때 호출
  Future<void> markRead(int notificationId) async {
    try {
      await _notificationsApi.markRead(notificationId: notificationId);
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("");
    }
  }
}
