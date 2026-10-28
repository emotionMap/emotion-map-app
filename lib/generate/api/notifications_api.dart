//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_integer.dart';
import 'package:emotion_map_app/generate/model/api_response_list_notification_response.dart';
import 'package:emotion_map_app/generate/model/api_response_void.dart';

part 'notifications_api.g.dart';

@RestApi()
abstract class NotificationsApi {
  factory NotificationsApi(Dio dio, {String? baseUrl}) = _NotificationsApi;

  /// 알림 목록 조회
  ///
  ///
  /// Parameters:
  /// * [page]
  /// * [size]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/notifications')
  Future<ApiResponseListNotificationResponse> getNotifications({
    @Query('page') int? page = 1,
    @Query('size') int? size = 20,
    CancelToken? cancelToken,
  });

  /// 안읽은 알림 개수
  /// 피드 상단 알림 뱃지 활성/비활성 판단용 (0이면 비활성)
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/notifications/unread-count')
  Future<ApiResponseInteger> getUnreadCount({CancelToken? cancelToken});

  /// 전체 읽음 처리
  /// 알림 목록 화면 진입 시 호출 - 알림 뱃지 비활성화
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/notifications/read-all')
  Future<ApiResponseVoid> readAll({CancelToken? cancelToken});
}
