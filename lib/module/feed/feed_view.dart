import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/module/feed/widget/post_list_body.dart';
import 'package:emotion_map_app/module/main_tabs/tab_index.dart';
import 'package:emotion_map_app/module/main_tabs/tab_scroll_signals.dart';
import 'package:emotion_map_app/util/tab_reentry.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 피드 탭에 재진입할 때마다(새 글 작성 후 자동 전환 포함) 목록을 새로 불러오도록,
/// 실제 내용은 [_FeedBody]에 두고 이 위젯은 재진입 키만 관리한다.
@RoutePage()
class FeedView extends HookWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final reentryKey = useTabReentryKey(context, kFeedTabIndex);
    return _FeedBody(key: ValueKey(reentryKey));
  }
}

class _FeedBody extends HookConsumerWidget {
  const _FeedBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsService = ref.read(postsServiceProvider);

    return Scaffold(
      appBar: const EMTopBar(title: '감정연결지도'),
      body: PostListBody(
        fetchPage: (page) => postsService.getPostList(page: page),
        scrollToTopSignal: feedScrollToTopSignal,
      ),
    );
  }
}
