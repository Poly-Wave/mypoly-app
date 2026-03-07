import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypoly/enum/flavor.dart';
import 'package:mypoly/firebase_options_dev.dart' as dev;
import 'package:mypoly/firebase_options_prod.dart' as prod;
import 'package:mypoly/model/env.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/logger.dart';
import 'package:mypoly/widget/index.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

const systemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarContrastEnforced: false,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
  systemStatusBarContrastEnforced: false,
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
);

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final flavor = Flavor.fromString(appFlavor ?? "prod");
  await dotenv.load(fileName: ".env.${flavor.name}");

  final firebaseOptions = flavor == .prod
      ? prod.DefaultFirebaseOptions.currentPlatform
      : dev.DefaultFirebaseOptions.currentPlatform;

  await Firebase.initializeApp(options: firebaseOptions);

  if (Platform.isAndroid) {
    await GoogleSignIn.instance.initialize(
      serverClientId: firebaseOptions.androidClientId,
    );
  }

  final env = Env(
    baseApiUrl: dotenv.get('BASE_API_URL'),
    kakaoJsKey: dotenv.get('KAKAO_JS_KEY'),
    kakaoNativeKey: dotenv.get('KAKAO_NATIVE_KEY'),
  )..init();

  final secureStorage = FlutterSecureStorage();

  final localStorage = await SharedPreferences.getInstance();

  final packageInfo = await PackageInfo.fromPlatform();

  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      overrides: [
        flavorProvider.overrideWithValue(flavor),
        secureStorageProvider.overrideWithValue(secureStorage),
        localStorageProvider.overrideWithValue(localStorage),
        packageInfoProvider.overrideWithValue(packageInfo),
        envProvider.overrideWithValue(env),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        fontSizeResolver: (fontSize, instance) =>
            FontSizeResolvers.radius(fontSize, instance),
        child: GlobalLoaderOverlay(
          overlayColor: ColorStyles.dim,
          overlayWidgetBuilder: (_) => Center(child: MPLoading()),
          child: MaterialApp.router(
            theme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: ColorStyles.black,
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: router.config(),
            builder: (context, widget) {
              final mediaQuery = MediaQuery.of(context);
              final screenWidth = mediaQuery.size.width;
              const maxMobileWidth = 450;

              Widget child = widget ?? const SizedBox.shrink();

              if (screenWidth > maxMobileWidth) {
                child = Container(
                  color: ColorStyles.black,
                  alignment: Alignment.center,
                  child: SizedBox(width: 360, child: child),
                );
              }

              return MediaQuery.withNoTextScaling(child: child);
            },
          ),
        ),
      ),
    );
  }
}
