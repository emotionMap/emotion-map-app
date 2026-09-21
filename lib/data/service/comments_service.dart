import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/comments_api.dart';
import 'package:emotion_map_app/generate/model/comment_create_request.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';

class CommentsService {
  final CommentsApi _commentsApi;

  CommentsService(this._commentsApi);

  /// parentCommentId 없으면 게시글에 바로 다는 최상위 댓글, 있으면 그 댓글의 대댓글
  Future<void> createComment(
    int postId,
    String content, {
    int? parentCommentId,
  }) async {
    try {
      await _commentsApi.createComment(
        postId: postId,
        commentCreateRequest: CommentCreateRequest(
          content: content,
          parentCommentId: parentCommentId,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<void> deleteComment(int commentId) async {
    try {
      await _commentsApi.deleteComment(commentId: commentId);
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
