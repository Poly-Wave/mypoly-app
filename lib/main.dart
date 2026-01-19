import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypoly/enum/flavor.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';

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

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final flavor = Flavor.fromString(appFlavor ?? "prod");

  print(flavor);

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        fontSizeResolver: (fontSize, instance) =>
            FontSizeResolvers.radius(fontSize, instance),
        child: GlobalLoaderOverlay(
          child: MaterialApp.router(
            theme: ThemeData(scaffoldBackgroundColor: ColorStyles.black),
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
