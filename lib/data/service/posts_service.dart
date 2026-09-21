import 'package:dio/dio.dart';
import 'package:emotion_map_app/generate/api/posts_api.dart';
import 'package:emotion_map_app/generate/model/emotion_stat_response.dart';
import 'package:emotion_map_app/generate/model/post_create_request.dart';
import 'package:emotion_map_app/generate/model/post_detail_response.dart';
import 'package:emotion_map_app/generate/model/post_list_response.dart';
import 'package:emotion_map_app/generate/model/post_update_request.dart';
import 'package:emotion_map_app/util/error.dart';
import 'package:flutter/foundation.dart';

class PostsService {
  final PostsApi _postsApi;

  PostsService(this._postsApi);

  Future<List<PostListResponse>> getPostList({
    required int page,
    int size = 20,
    int? locationId,
  }) async {
    try {
      final response = await _postsApi.getPostList(
        page: page,
        size: size,
        locationId: locationId,
      );
      return response.data ?? [];
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<List<PostListResponse>> myPosts({
    required int page,
    int size = 20,
  }) async {
    try {
      final response = await _postsApi.myPosts(page: page, size: size);
      return response.data ?? [];
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<PostDetailResponse> getPost(int postId) async {
    try {
      final response = await _postsApi.getPost(postId: postId);
      final data = response.data;
      if (data == null) return Future.error("error");
      return data;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  /// 좋아요 토글 - "Y"(추가) / "N"(취소) 반환
  Future<String> toggleLike(int postId) async {
    try {
      final response = await _postsApi.toggleLike(postId: postId);
      return response.data ?? "N";
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<int> createPost({
    required int locationId,
    required List<int> emotionIds,
    String? content,
  }) async {
    try {
      final response = await _postsApi.createPost(
        postCreateRequest: PostCreateRequest(
          locationId: locationId,
          emotionIds: emotionIds,
          content: content,
        ),
      );
      return response.data ?? 0;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<void> updatePost({
    required int postId,
    required int locationId,
    required List<int> emotionIds,
    String? content,
  }) async {
    try {
      await _postsApi.updatePost(
        postId: postId,
        postUpdateRequest: PostUpdateRequest(
          locationId: locationId,
          emotionIds: emotionIds,
          content: content,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      await _postsApi.deletePost(postId: postId);
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<List<EmotionStatResponse>> myEmotionStats(int days) async {
    try {
      final response = await _postsApi.myEmotionStats(days: days);
      return response.data ?? [];
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
