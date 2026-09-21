import 'package:emotion_map_app/enum/app_mode.dart';
import 'package:emotion_map_app/provider/app_provider.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
