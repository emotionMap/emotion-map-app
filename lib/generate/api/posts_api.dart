//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_list_emotion_stat_response.dart';
import 'package:emotion_map_app/generate/model/api_response_list_post_list_response.dart';
import 'package:emotion_map_app/generate/model/api_response_long.dart';
import 'package:emotion_map_app/generate/model/api_response_post_detail_response.dart';
import 'package:emotion_map_app/generate/model/api_response_string.dart';
import 'package:emotion_map_app/generate/model/api_response_void.dart';
import 'package:emotion_map_app/generate/model/post_create_request.dart';
import 'package:emotion_map_app/generate/model/post_update_request.dart';

part 'posts_api.g.dart';

@RestApi()
abstract class PostsApi {
  factory PostsApi(Dio dio, {String? baseUrl}) = _PostsApi;

  /// 포스트 생성
  ///
  ///
  /// Parameters:
  /// * [postCreateRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/posts')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseLong> createPost({
    @Body() required PostCreateRequest postCreateRequest,
    CancelToken? cancelToken,
  });

  /// 포스트 삭제
  ///
  ///
  /// Parameters:
  /// * [postId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @DELETE('/posts/{postId}')
  Future<ApiResponseVoid> deletePost({
    @Path('postId') required int postId,
    CancelToken? cancelToken,
  });

  /// 포스트 디테일 조회
  ///
  ///
  /// Parameters:
  /// * [postId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/posts/{postId}')
  Future<ApiResponsePostDetailResponse> getPost({
    @Path('postId') required int postId,
    CancelToken? cancelToken,
  });

  /// 포스트 리스트 조회
  /// locationId 생략 시 내 계정 위치, 지정 시 그 지역으로 조회 (지도에서 지역 선택 시 사용)
  ///
  /// Parameters:
  /// * [page]
  /// * [size]
  /// * [locationId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/posts')
  Future<ApiResponseListPostListResponse> getPostList({
    @Query('page') int? page = 1,
    @Query('size') int? size = 20,
    @Query('locationId') int? locationId,
    CancelToken? cancelToken,
  });

  /// 마이페이지 - 개인 감정 통계
  /// 최근 N일간(days) 내가 작성한 게시글의 감정 태그별 사용 횟수, 많이 쓴 순
  ///
  /// Parameters:
  /// * [days]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/posts/me/emotion-stats')
  Future<ApiResponseListEmotionStatResponse> myEmotionStats({
    @Query('days') int? days = 7,
    CancelToken? cancelToken,
  });

  /// 내가 작성한 포스트
  ///
  ///
  /// Parameters:
  /// * [page]
  /// * [size]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/posts/me')
  Future<ApiResponseListPostListResponse> myPosts({
    @Query('page') int? page = 1,
    @Query('size') int? size = 20,
    CancelToken? cancelToken,
  });

  /// 좋아요 토글 (없으면 추가, 있으면 취소)
  ///
  ///
  /// Parameters:
  /// * [postId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/posts/{postId}/like')
  Future<ApiResponseString> toggleLike({
    @Path('postId') required int postId,
    CancelToken? cancelToken,
  });

  /// 포스트 수정
  ///
  ///
  /// Parameters:
  /// * [postId]
  /// * [postUpdateRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/posts/{postId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseVoid> updatePost({
    @Path('postId') required int postId,
    @Body() required PostUpdateRequest postUpdateRequest,
    CancelToken? cancelToken,
  });
}
