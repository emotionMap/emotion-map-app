import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/enum/app_mode.dart';
import 'package:emotion_map_app/module/feed/widget/notification_signal.dart';
import 'package:emotion_map_app/provider/app_provider.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/util/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final appMode = AppMode.fromString(appFlavor ?? "prod");
  if (appMode == .prod) {
    await dotenv.load(fileName: ".env");
  } else {
    await dotenv.load(fileName: ".env.${appMode.name}");
  }

  await Firebase.initializeApp();

  final secureStorage = FlutterSecureStorage();

  final localStorage = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      observers: const [ProviderLogger()],
      overrides: [
        appModeProvider.overrideWithValue(appMode),
        secureStorageProvider.overrideWithValue(secureStorage),
        localStorageProvider.overrideWithValue(localStorage),
        apiUrlProvider.overrideWithValue(dotenv.get("API_URL")),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    void navigateToPost(RemoteMessage message) {
      final postId = int.tryParse(message.data['postId'] ?? '');
      if (postId == null) return;
      router.push(PostDetailRoute(postId: postId));
    }

    useEffect(() {
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) navigateToPost(message);
      });

      final openedSub = FirebaseMessaging.onMessageOpenedApp.listen(
        navigateToPost,
      );
      // 포그라운드에서는 OS가 배너를 띄워주지 않으니, 벨 뱃지만 즉시 갱신한다.
      final foregroundSub = FirebaseMessaging.onMessage.listen((_) {
        notificationsChangedSignal.value++;
      });
      final tokenSub = ref
          .read(fcmServiceProvider)
          .onTokenRefresh
          .listen((_) => ref.read(fcmServiceProvider).syncToken());

      return () {
        openedSub.cancel();
        foregroundSub.cancel();
        tokenSub.cancel();
      };
      // ignore: exhaustive_keys
    }, const []);

    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (_) =>
          Center(child: SpinKitCircle(size: 70, color: AppColors.accent)),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle,
        child: MaterialApp.router(
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'NotoSansKR',
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.accent,
              brightness: Brightness.light,
            ).copyWith(surface: AppColors.surface, error: AppColors.error),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.background,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
            ),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: router.config(),
          builder: (context, widget) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MediaQuery.withNoTextScaling(
              child: widget ?? const SizedBox.shrink(),
            ),
          ),
          // home: const CustomSplashPage(),
        ),
      ),
    );
  }
}
