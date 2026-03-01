import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Common
import 'package:mypoly/module/common/term/term_view.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';

// Splash
import 'package:mypoly/module/splash/splash_view.dart';

// Onboard
import 'package:mypoly/module/onboard/onboard_view.dart';

import 'package:mypoly/module/onboard/register/nickname/register_nickname_view.dart';
import 'package:mypoly/generate/users/model/terms_agreement_request.dart';
import 'package:mypoly/enum/social.dart';

import 'package:mypoly/module/onboard/register/onboard/register_onboard_view.dart';
import 'package:mypoly/module/onboard/register/more/register_more_view.dart';
import 'package:mypoly/module/onboard/register/topic/register_topic_view.dart';
import 'package:mypoly/module/onboard/register/complete/register_complete_view.dart';

// Main
import 'package:mypoly/module/main/main_view.dart';

// Home

// Agenda

// Subsidy

part 'router_provider.gr.dart';
part 'router_provider.g.dart';

@AutoRouterConfig(replaceInRouteName: 'ProviderView|View,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    // Common
    AutoRoute(page: TermRoute.page),

    // Splash
    CustomRoute(
      initial: true,
      page: SplashRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),

    // Onboard
    AutoRoute(page: OnboardRoute.page),

    AutoRoute(page: RegisterNicknameRoute.page),
    AutoRoute(page: RegisterOnboardRoute.page),
    AutoRoute(page: RegisterMoreRoute.page),
    AutoRoute(page: RegisterTopicRoute.page),
    AutoRoute(page: RegisterCompleteRoute.page),

    // Main
    AutoRoute(page: MainRoute.page),

    // Home

    // Agenda

    // Subsidy
  ];
}

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> rootNavigatorKey(Ref ref) =>
    GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
AppRouter router(Ref ref) =>
    AppRouter(navigatorKey: ref.watch(rootNavigatorKeyProvider));
