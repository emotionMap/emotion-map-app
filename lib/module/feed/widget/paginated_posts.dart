import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/generate/model/post_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 다른 화면(게시글 상세 등)에서 글이 삭제/수정되면 이 값을 증가시킨다.
/// [usePaginatedPosts]를 쓰는 모든 목록(피드, 지역 피드, 마이페이지)이 이 신호를
/// 구독해 자동으로 새로고침한다 - 탭을 벗어났다 돌아오는 경우가 아니라 화면 위에
/// push된 상세 화면에서 뒤로가기(pop)로 돌아오는 경우처럼, 탭 전환이 없어 재진입
/// 새로고침이 걸리지 않는 경로를 커버하기 위함이다.
final postsChangedSignal = ValueNotifier<int>(0);

/// [usePaginatedPosts]의 반환값 - 목록 상태와 그걸 조작하는 함수들을 한데 묶는다.
class PaginatedPosts {
  final List<PostListResponse> posts;
  final bool hasMore;
  final bool loading;
  final bool initialLoading;
  final Future<void> Function({bool reset}) load;
  final Future<void> Function(PostListResponse post) onLikeTap;

  PaginatedPosts({
    required this.posts,
    required this.hasMore,
    required this.loading,
    required this.initialLoading,
    required this.load,
    required this.onLikeTap,
  });
}

/// 페이지네이션 + 좋아요 토글 상태를 관리하는 공용 훅.
/// [PostListBody](ListView 기반)와 마이페이지(CustomScrollView 기반)처럼
/// 렌더링 방식이 다른 화면에서도 같은 상태 로직을 재사용하기 위해 분리했다.
PaginatedPosts usePaginatedPosts(
  BuildContext context,
  WidgetRef ref,
  Future<List<PostListResponse>> Function(int page) fetchPage, {
  int pageSize = 20,
}) {
  final posts = useState<List<PostListResponse>>([]);
  final nextPage = useState(1);
  final hasMore = useState(true);
  final loading = useState(false);
  final initialLoading = useState(true);
  final postsService = ref.read(postsServiceProvider);

  Future<void> load({bool reset = false}) async {
    if (loading.value) return;
    loading.value = true;
    try {
      final targetPage = reset ? 1 : nextPage.value;
      final result = await fetchPage(targetPage);
      posts.value = reset ? result : [...posts.value, ...result];
      nextPage.value = targetPage + 1;
      hasMore.value = result.length >= pageSize;
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('불러오지 못했어요.')));
      }
    } finally {
      loading.value = false;
      initialLoading.value = false;
    }
  }

  useEffect(() {
    load(reset: true);
    return null;
    // ignore: exhaustive_keys
  }, const []);

  useEffect(() {
    void onPostsChanged() => load(reset: true);
    postsChangedSignal.addListener(onPostsChanged);
    return () => postsChangedSignal.removeListener(onPostsChanged);
    // ignore: exhaustive_keys
  }, const []);

  Future<void> onLikeTap(PostListResponse post) async {
    final postId = post.postId;
    if (postId == null) return;
    try {
      final result = await postsService.toggleLike(postId);
      final liked = result == 'Y';
      final wasLiked = post.likeYN == 'Y';
      final delta = liked == wasLiked ? 0 : (liked ? 1 : -1);
      posts.value = posts.value
          .map(
            (p) => p.postId == postId
                ? p.copyWith(
                    likeYN: liked ? 'Y' : 'N',
                    likeCount: (p.likeCount ?? 0) + delta,
                  )
                : p,
          )
          .toList();
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('좋아요 처리에 실패했어요.')));
      }
    }
  }

  return PaginatedPosts(
    posts: posts.value,
    hasMore: hasMore.value,
    loading: loading.value,
    initialLoading: initialLoading.value,
    load: load,
    onLikeTap: onLikeTap,
  );
}
