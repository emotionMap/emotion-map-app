import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/generate/model/emotion_stat_response.dart';
import 'package:emotion_map_app/generate/model/post_list_response.dart';
import 'package:emotion_map_app/module/feed/widget/paginated_posts.dart';
import 'package:emotion_map_app/module/feed/widget/post_card.dart';
import 'package:emotion_map_app/module/main_tabs/tab_index.dart';
import 'package:emotion_map_app/module/main_tabs/tab_scroll_signals.dart';
import 'package:emotion_map_app/module/mypage/widget/days_chip.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/util/tab_reentry.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 통계 박스에는 상위 N개만 보여준다. 박스 안에 또 스크롤을 넣으면(세로 스크롤
/// 안의 세로 스크롤) 페이지를 넘기려다 박스만 움직이는 제스처 충돌이 생겨서,
/// 대신 그 이상은 "전체보기" 바텀시트로 분리한다.
const _statsVisibleRows = 5;

/// 마이페이지 탭에 재진입할 때마다 통계/내 글 목록이 새로 마운트되도록,
/// 실제 내용은 [_MyPageBody]에 두고 이 위젯은 재진입 키만 관리한다.
@RoutePage()
class MyPageView extends HookWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final reentryKey = useTabReentryKey(context, kMyPageTabIndex);
    return _MyPageBody(key: ValueKey(reentryKey));
  }
}

class _MyPageBody extends HookConsumerWidget {
  const _MyPageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsService = ref.read(postsServiceProvider);

    final days = useState(7);
    final stats = useState<List<EmotionStatResponse>>([]);
    final statsLoading = useState(true);
    final statsExpanded = useState(true);
    final scrollController = useScrollController();

    Future<void> fetchStats() async {
      statsLoading.value = true;
      try {
        stats.value = await postsService.myEmotionStats(days.value);
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('통계를 불러오지 못했어요.')));
        }
      } finally {
        statsLoading.value = false;
      }
    }

    useEffect(() {
      fetchStats();
      return null;
    }, [days.value]);

    final postsState = usePaginatedPosts(
      context,
      ref,
      (page) => postsService.myPosts(page: page),
    );

    useEffect(() {
      void onScroll() {
        if (!scrollController.hasClients) return;
        final nearBottom =
            scrollController.position.pixels >
            scrollController.position.maxScrollExtent - 240;
        if (nearBottom && postsState.hasMore && !postsState.loading) {
          postsState.load();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
      // ignore: exhaustive_keys
    }, [scrollController, postsState.hasMore, postsState.loading]);

    useEffect(() {
      void onScrollToTop() {
        if (!scrollController.hasClients) return;
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }

      myPageScrollToTopSignal.addListener(onScrollToTop);
      return () => myPageScrollToTopSignal.removeListener(onScrollToTop);
    }, [scrollController]);

    void onPostTap(PostListResponse post) {
      final postId = post.postId;
      if (postId == null) return;
      context.router.push(PostDetailRoute(postId: postId));
    }

    final maxCount = stats.value.fold<int>(
      0,
      (m, s) => (s.count ?? 0) > m ? (s.count ?? 0) : m,
    );

    return Scaffold(
      appBar: const EMTopBar(title: '마이페이지'),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([fetchStats(), postsState.load(reset: true)]);
        },
        color: AppColors.accent,
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: AppDecorations.card(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '나의 감정 통계',
                            style: NotoSansKR.bold.set(
                              size: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          DaysChip(
                            label: '7일',
                            selected: days.value == 7,
                            onTap: () => days.value = 7,
                          ),
                          const EMWidth(6),
                          DaysChip(
                            label: '30일',
                            selected: days.value == 30,
                            onTap: () => days.value = 30,
                          ),
                          const EMWidth(4),
                          InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () =>
                                statsExpanded.value = !statsExpanded.value,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                statsExpanded.value
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                size: 20,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (statsExpanded.value) ...[
                        const EMHeight(14),
                        if (statsLoading.value)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else if (stats.value.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text(
                                '최근 ${days.value}일간 기록이 없어요',
                                style: NotoSansKR.medium.set(
                                  size: 13,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          )
                        else ...[
                          Column(
                            children: [
                              for (final s in stats.value.take(
                                _statsVisibleRows,
                              ))
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: _EmotionStatRow(
                                    stat: s,
                                    ratio: maxCount == 0
                                        ? 0.0
                                        : (s.count ?? 0) / maxCount,
                                  ),
                                ),
                            ],
                          ),
                          if (stats.value.length > _statsVisibleRows)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => _showAllStats(
                                  context,
                                  stats.value,
                                  maxCount,
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  '전체보기 (${stats.value.length})',
                                  style: NotoSansKR.medium.set(
                                    size: 12,
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  '내가 쓴 글',
                  style: NotoSansKR.bold.set(
                    size: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            if (postsState.initialLoading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            else if (postsState.posts.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                    child: Text(
                      '아직 작성한 글이 없어요',
                      style: NotoSansKR.medium.set(
                        size: 14,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverList.separated(
                  itemCount:
                      postsState.posts.length + (postsState.hasMore ? 1 : 0),
                  separatorBuilder: (_, _) => const EMHeight(12),
                  itemBuilder: (context, index) {
                    if (index >= postsState.posts.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                            ),
                          ),
                        ),
                      );
                    }
                    final post = postsState.posts[index];
                    return PostCard(
                      post: post,
                      onTap: () => onPostTap(post),
                      onLikeTap: () => postsState.onLikeTap(post),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void _showAllStats(
  BuildContext context,
  List<EmotionStatResponse> stats,
  int maxCount,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // 통계 막대 배경(AppColors.background)이 시트와 같은 색이면 안 보이니
    // 시트는 surface로 - 카드 안에서 쓰던 것과 같은 배경/표면 대비 유지.
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => SizedBox(
      height: MediaQuery.of(sheetContext).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: Text(
              '전체 감정 통계',
              style: NotoSansKR.bold.set(size: 16, color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: stats.length,
              separatorBuilder: (_, _) => const EMHeight(12),
              itemBuilder: (context, index) {
                final s = stats[index];
                return _EmotionStatRow(
                  stat: s,
                  ratio: maxCount == 0 ? 0.0 : (s.count ?? 0) / maxCount,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class _EmotionStatRow extends StatelessWidget {
  final EmotionStatResponse stat;
  final double ratio;

  const _EmotionStatRow({required this.stat, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: Row(
        children: [
          Text(stat.emoji ?? '', style: const TextStyle(fontSize: 18)),
          const EMWidth(8),
          SizedBox(
            width: 44,
            child: Text(
              stat.name ?? '',
              overflow: TextOverflow.ellipsis,
              style: NotoSansKR.medium.set(
                size: 12,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const EMWidth(8),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: ratio.clamp(0.04, 1.0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const EMWidth(8),
          Text(
            '${stat.count ?? 0}',
            style: NotoSansKR.semiBold.set(
              size: 12,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
