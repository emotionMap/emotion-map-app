import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/module/feed/widget/post_list_body.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 지도에서 지역 카드를 탭했을 때 진입하는 "그 지역 피드".
/// 별도 API 없이 GET /posts?locationId= 를 기존 피드 리스트 위젯 그대로 재사용한다.
@RoutePage()
class RegionFeedView extends HookConsumerWidget {
  final int locationId;
  final String title;

  const RegionFeedView({
    super.key,
    required this.locationId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsService = ref.read(postsServiceProvider);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PostListBody(
        fetchPage: (page) =>
            postsService.getPostList(page: page, locationId: locationId),
      ),
    );
  }
}
