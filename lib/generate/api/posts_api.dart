//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_post_detail_response.dart';
import 'package:emotion_map_app/generate/model/api_response_post_list_response.dart';
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
  @POST('/posts/create')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseVoid> createPost({
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
  @POST('/posts/delete/{postId}')
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
  @GET('/posts/detail/{postId}')
  Future<ApiResponsePostDetailResponse> getPost({
    @Path('postId') required int postId,
    CancelToken? cancelToken,
  });

  /// 포스트 리스트 조회
  ///
  ///
  /// Parameters:
  /// * [page]
  /// * [size]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/posts')
  Future<ApiResponsePostListResponse> getPostList({
    @Query('page') int? page = 1,
    @Query('size') int? size = 20,
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
  @POST('/posts/update/{postId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseVoid> updatePost({
    @Path('postId') required int postId,
    @Body() required PostUpdateRequest postUpdateRequest,
    CancelToken? cancelToken,
  });
}
