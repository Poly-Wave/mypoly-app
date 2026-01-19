import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Splash
import 'package:mypoly/module/splash/splash_view.dart';

// Onboard
import 'package:mypoly/module/onboard/onboard_view.dart';

// Main
import 'package:mypoly/module/main/main_view.dart';

part 'router_provider.gr.dart';
part 'router_provider.g.dart';

@AutoRouterConfig(replaceInRouteName: 'ProviderView|View,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    // Splash
    CustomRoute(
      initial: true,
      page: SplashRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),

    // Onboard
    AutoRoute(page: OnboardRoute.page),

    // Main
    AutoRoute(page: MainRoute.page),
  ];
}

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> rootNavigatorKey(Ref ref) =>
    GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
AppRouter router(Ref ref) =>
    AppRouter(navigatorKey: ref.watch(rootNavigatorKeyProvider));
