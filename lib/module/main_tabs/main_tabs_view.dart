import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/module/main_tabs/tab_index.dart';
import 'package:emotion_map_app/module/main_tabs/tab_scroll_signals.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:flutter/material.dart';

/// 하단 탭 4개(피드/글쓰기/지도/마이페이지)를 감싸는 루트 셸.
@RoutePage()
class MainTabsView extends StatelessWidget {
  const MainTabsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [FeedRoute(), WriteRoute(), MapRoute(), MyPageRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        void onTabTap(int index) {
          if (index == kFeedTabIndex) {
            feedScrollToTopSignal.value++;
          } else if (index == kMyPageTabIndex) {
            myPageScrollToTopSignal.value++;
          }
          tabsRouter.setActiveIndex(index);
        }

        return Scaffold(
          body: child,
          bottomNavigationBar: Container(
            decoration: AppDecorations.elevatedBar(),
            child: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: onTabTap,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: AppColors.accent,
              unselectedItemColor: AppColors.textMuted,
              selectedLabelStyle: NotoSansKR.medium.set(size: 11),
              unselectedLabelStyle: NotoSansKR.regular.set(size: 11),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: '피드',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit_outlined),
                  activeIcon: Icon(Icons.edit),
                  label: '글쓰기',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined),
                  activeIcon: Icon(Icons.map),
                  label: '지도',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: '마이',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
