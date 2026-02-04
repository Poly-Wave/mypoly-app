import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/module/main/home/section/notice_section.dart';
import 'package:mypoly/module/main/home/section/my_info_section.dart';
import 'package:mypoly/module/main/home/section/agenda_intro_section.dart';
import 'package:mypoly/module/main/home/section/popular_subsidy_section.dart';
import 'package:mypoly/module/main/home/widget/home_app_bar.dart';
import 'package:mypoly/module/main/home/widget/home_bottom_bar.dart';

@RoutePage()
class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FlutterNativeSplash.remove();
      });

      return null;
    }, []);
    
    return Scaffold(
      appBar: HomeAppBar(),
      
      body: ListView(
        children: [
          NoticeSection(),  // 공지사항
          MyInfoSection(),  // 내 정보

          SizedBox(height: 50.h),

          AgendaIntroSection(),  // 안건 소개
          PopularSubsidySection(),  // 인기 보조금
        ],
      ),
      
      bottomNavigationBar: HomeBottomBar(),
    ); 
  } 
}