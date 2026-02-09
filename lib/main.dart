import 'package:emotion_map_app/enum/app_mode.dart';
import 'package:emotion_map_app/provider/app_provider.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  KakaoSdk.init(
    nativeAppKey: dotenv.get('KAKAO_NATIVE_KEY'),
    javaScriptAppKey: dotenv.get('KAKAO_JS_KEY'),
  );

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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle,
        child: MaterialApp.router(
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
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
