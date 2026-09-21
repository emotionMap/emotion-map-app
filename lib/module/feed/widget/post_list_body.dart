import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/generate/model/post_list_response.dart';
import 'package:emotion_map_app/module/feed/widget/paginated_posts.dart';
import 'package:emotion_map_app/module/feed/widget/post_card.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 피드 / 지역 피드 목록에서 공용으로 쓰는
/// pull-to-refresh + 무한스크롤 + 좋아요 토글 리스트.
class PostListBody extends HookConsumerWidget {
  final Future<List<PostListResponse>> Function(int page) fetchPage;
  final int pageSize;
  final String emptyText;

  /// 값이 바뀔 때마다(예: 이미 활성화된 탭을 다시 눌렀을 때) 목록을 맨 위로
  /// 스크롤한다. 필요 없는 화면(마이페이지 등)에서는 생략하면 된다.
  final Listenable? scrollToTopSignal;

  const PostListBody({
    super.key,
    required this.fetchPage,
    this.pageSize = 20,
    this.emptyText = '아직 게시글이 없어요',
    this.scrollToTopSignal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final state = usePaginatedPosts(
      context,
      ref,
      fetchPage,
      pageSize: pageSize,
    );

    useEffect(() {
      void onScroll() {
        if (!scrollController.hasClients) return;
        final nearBottom =
            scrollController.position.pixels >
            scrollController.position.maxScrollExtent - 240;
        if (nearBottom && state.hasMore && !state.loading) {
          state.load();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
      // ignore: exhaustive_keys
    }, [scrollController, state.hasMore, state.loading]);

    useEffect(() {
      void onSignal() {
        if (!scrollController.hasClients) return;
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }

      scrollToTopSignal?.addListener(onSignal);
      return () => scrollToTopSignal?.removeListener(onSignal);
    }, [scrollToTopSignal]);

    void onPostTap(PostListResponse post) {
      final postId = post.postId;
      if (postId == null) return;
      context.router.push(PostDetailRoute(postId: postId));
    }

    if (state.initialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () => state.load(reset: true),
      color: AppColors.accent,
      child: state.posts.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const EMHeight(160),
                Center(
                  child: Text(
                    emptyText,
                    style: NotoSansKR.medium.set(
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            )
          : ListView.separated(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: state.posts.length + (state.hasMore ? 1 : 0),
              separatorBuilder: (_, _) => const EMHeight(12),
              itemBuilder: (context, index) {
                if (index >= state.posts.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.4),
                      ),
                    ),
                  );
                }
                final post = state.posts[index];
                return PostCard(
                  post: post,
                  onTap: () => onPostTap(post),
                  onLikeTap: () => state.onLikeTap(post),
                );
              },
            ),
    );
  }
}
