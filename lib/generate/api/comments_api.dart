//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:emotion_map_app/generate/model/api_response_long.dart';
import 'package:emotion_map_app/generate/model/api_response_void.dart';
import 'package:emotion_map_app/generate/model/comment_create_request.dart';
import 'package:emotion_map_app/generate/model/comment_update_request.dart';

part 'comments_api.g.dart';

@RestApi()
abstract class CommentsApi {
  factory CommentsApi(Dio dio, {String? baseUrl}) = _CommentsApi;

  /// 댓글/대댓글 작성
  /// parentCommentId가 없으면 게시글에 바로 다는 최상위 댓글, 있으면 그 댓글의 대댓글
  ///
  /// Parameters:
  /// * [postId]
  /// * [commentCreateRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/posts/{postId}/comments')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseLong> createComment({
    @Path('postId') required int postId,
    @Body() required CommentCreateRequest commentCreateRequest,
    CancelToken? cancelToken,
  });

  /// 댓글 삭제
  /// soft delete - 대댓글은 트리에 그대로 남는다
  ///
  /// Parameters:
  /// * [commentId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @DELETE('/comments/{commentId}')
  Future<ApiResponseVoid> deleteComment({
    @Path('commentId') required int commentId,
    CancelToken? cancelToken,
  });

  /// 댓글 수정
  ///
  ///
  /// Parameters:
  /// * [commentId]
  /// * [commentUpdateRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/comments/{commentId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<ApiResponseVoid> updateComment({
    @Path('commentId') required int commentId,
    @Body() required CommentUpdateRequest commentUpdateRequest,
    CancelToken? cancelToken,
  });
}
