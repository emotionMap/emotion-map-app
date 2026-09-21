import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 하단탭 [tabIndex]가 활성화될 때마다(같은 탭을 다시 눌러 재진입할 때 포함) 값이
/// 바뀌는 카운터를 돌려준다. 이 값을 화면 본문 위젯의 key로 쓰면, 탭에 재진입할
/// 때마다 그 서브트리가 완전히 새로 마운트되어(내부 useState/useEffect 초기화)
/// "새로고침되며 진입"하는 효과를 낸다.
///
/// AutoTabsRouter는 모든 탭을 미리 마운트해두고 그대로 유지하기 때문에, 단순
/// useEffect(() {}, [])만으로는 탭을 눌러 재진입해도 다시 실행되지 않는다.
int useTabReentryKey(BuildContext context, int tabIndex) {
  final tabsRouter = AutoTabsRouter.of(context);
  final counter = useState(0);

  useEffect(() {
    void listener() {
      if (tabsRouter.activeIndex == tabIndex) {
        counter.value++;
      }
    }

    tabsRouter.addListener(listener);
    return () => tabsRouter.removeListener(listener);
  }, [tabsRouter]);

  return counter.value;
}
