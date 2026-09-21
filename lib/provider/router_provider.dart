import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/generate/model/post.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Onboard
import 'package:emotion_map_app/module/onboard/onboard_view.dart';
// Location
import 'package:emotion_map_app/module/location/location_setup_view.dart';
// Main tabs
import 'package:emotion_map_app/module/main_tabs/main_tabs_view.dart';
// Feed
import 'package:emotion_map_app/module/feed/feed_view.dart';
// Write
import 'package:emotion_map_app/module/write/write_view.dart';
// Post
import 'package:emotion_map_app/module/post/post_detail_view.dart';
import 'package:emotion_map_app/module/post/post_edit_view.dart';
// Map
import 'package:emotion_map_app/module/map/map_view.dart';
import 'package:emotion_map_app/module/map/region_feed_view.dart';
// MyPage
import 'package:emotion_map_app/module/mypage/mypage_view.dart';

part 'router_provider.gr.dart';
part 'router_provider.g.dart';

@AutoRouterConfig(replaceInRouteName: 'ProviderView|View,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: OnboardRoute.page),
    AutoRoute(page: LocationSetupRoute.page),
    AutoRoute(
      page: MainTabsRoute.page,
      children: [
        AutoRoute(page: FeedRoute.page),
        AutoRoute(page: WriteRoute.page),
        AutoRoute(page: MapRoute.page),
        AutoRoute(page: MyPageRoute.page),
      ],
    ),
    AutoRoute(page: PostDetailRoute.page),
    AutoRoute(page: PostEditRoute.page),
    AutoRoute(page: RegionFeedRoute.page),
  ];
}

@Riverpod(keepAlive: true)
AppRouter router(Ref ref) => AppRouter();
