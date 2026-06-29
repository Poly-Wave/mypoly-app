import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Common
import 'package:mypoly/module/common/term_detail/term_detail_view.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:mypoly/module/common/topic/topic_view.dart';
import 'package:mypoly/module/common/talker/talker_view.dart';

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
import 'package:mypoly/module/main/home/main_home_view.dart';
import 'package:mypoly/module/main/home/agenda/detail/agenda_detail_view.dart';
import 'package:mypoly/module/main/home/search/search_view.dart';
import 'package:mypoly/module/main/home/notification/notification_view.dart';

import 'package:mypoly/module/main/home/bookmark/bookmark_view.dart';
import 'package:mypoly/module/main/home/vote/vote_view.dart';

import 'package:mypoly/module/main/home/my_info/my_info_view.dart';
import 'package:mypoly/module/main/home/my_info/edit/my_info_edit_view.dart';
import 'package:mypoly/module/main/home/my_info/detail/my_info_detail_view.dart';
import 'package:mypoly/module/main/home/my_info/term/term_view.dart';
import 'package:mypoly/module/main/home/my_info/notice/notice_view.dart';
import 'package:mypoly/module/main/home/my_info/notice/detail/notice_detail_view.dart';
import 'package:mypoly/module/main/home/my_info/oss/oss_view.dart';
import 'package:mypoly/module/main/home/my_info/delete/delete_account_view.dart';

// Agenda
import 'package:mypoly/module/main/agenda/main_agenda_view.dart';

// Subsidy

part 'router_provider.gr.dart';
part 'router_provider.g.dart';

@AutoRouterConfig(replaceInRouteName: 'ProviderView|View,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    // Common
    AutoRoute(page: TermDetailRoute.page),
    AutoRoute(page: TopicRoute.page),
    AutoRoute(page: TalkerRoute.page),

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
    AutoRoute(page: AgendaDetailRoute.page),
    AutoRoute(page: SearchRoute.page),
    AutoRoute(page: NotificationRoute.page),

    AutoRoute(page: BookmarkRoute.page),
    AutoRoute(page: VoteRoute.page),

    AutoRoute(page: MyInfoRoute.page),
    AutoRoute(page: MyInfoEditRoute.page),
    AutoRoute(page: MyInfoDetailRoute.page),
    AutoRoute(page: TermRoute.page),
    AutoRoute(page: NoticeRoute.page),
    AutoRoute(page: NoticeDetailRoute.page),
    AutoRoute(page: OSSRoute.page),
    AutoRoute(page: DeleteAccountRoute.page),

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
