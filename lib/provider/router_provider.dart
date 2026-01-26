import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/module/onboard/register/register_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Onboard
import 'package:emotion_map_app/module/onboard/onboard_view.dart';

part 'router_provider.gr.dart';
part 'router_provider.g.dart';

@AutoRouterConfig(replaceInRouteName: 'ProviderView|View,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: OnboardRoute.page),
  ];
}

@Riverpod(keepAlive: true)
AppRouter router(Ref ref) => AppRouter();
