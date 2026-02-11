import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/module/main/home/section/agenda_intro_section.dart';
import 'package:mypoly/module/main/home/section/my_info_section.dart';
import 'package:mypoly/module/main/home/section/notice_section.dart';
import 'package:mypoly/module/main/home/section/popular_subsidy_section.dart';
import 'package:mypoly/module/main/home/widget/home_app_bar.dart';
import 'package:mypoly/widget/index.dart';

class MainHomeView extends HookConsumerWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: ListView(
        children: [
          NoticeSection(), // 공지사항
          MyInfoSection(), // 내 정보

          MPHeight(50),

          AgendaIntroSection(), // 안건 소개
          PopularSubsidySection(), // 인기 보조금
        ],
      ),
    );
  }
}
