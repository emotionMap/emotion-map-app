import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

const systemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarContrastEnforced: false,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemStatusBarContrastEnforced: false,
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ProviderScope(
      observers: const [ProviderLogger()],
      overrides: [],
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return GlobalLoaderOverlay(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router.config(),
          builder: (context, widget) => MediaQuery.withNoTextScaling(
            child: widget ?? const SizedBox.shrink(),
          ),
          // home: const CustomSplashPage(),
        ),
      ),
    );
  }
}
