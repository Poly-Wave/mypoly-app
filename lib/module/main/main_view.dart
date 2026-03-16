import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/module/main/agenda/main_agenda_view.dart';
import 'package:mypoly/module/main/home/main_home_view.dart';
import 'package:mypoly/module/main/main_provider.dart';
import 'package:mypoly/module/main/subsidy/main_subsidy_view.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class MainView extends HookConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FlutterNativeSplash.remove();
      });

      return null;
    }, []);

    final mainPage = ref.watch(mainPageProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: IndexedStack(
              index: mainPage,
              children: [MainAgendaView(), MainHomeView(), MainSubsidyView()],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorStyles.black,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.r,
                  offset: Offset(0, -4.h),
                  color: Colors.black.withValues(alpha: 0.08),
                ),
              ],
            ),
            child: MPSafeBox(
              bottom: true,
              child: SizedBox(
                height: 59.h,
                child: Row(
                  children: [
                    MainNavItem(
                      onTap: () =>
                          ref.read(mainPageProvider.notifier).update(0),
                      isActive: mainPage == 0,
                      text: "안건",
                      image: SvgImage.mainAgenda,
                    ),
                    MainNavItem(
                      onTap: () =>
                          ref.read(mainPageProvider.notifier).update(1),
                      isActive: mainPage == 1,
                      text: "홈",
                      image: SvgImage.mainHome,
                    ),
                    MainNavItem(
                      onTap: () =>
                          ref.read(mainPageProvider.notifier).update(2),
                      isActive: mainPage == 2,
                      text: "보조금",
                      image: SvgImage.mainSubsidy,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainNavItem extends StatelessWidget {
  final void Function() onTap;
  final bool isActive;
  final String text;
  final String image;

  const MainNavItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: .stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 3.h,
            children: [
              Center(
                child: Stack(
                  alignment: .center,
                  children: [
                    AnimatedOpacity(
                      opacity: isActive ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: MPSvgImage(
                        image,
                        size: 28,
                        color: ColorStyles.gray60,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: isActive ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: MPSvgImage(
                        image,
                        size: 28,
                        color: ColorStyles.primary50,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: .center,
                children: [
                  AnimatedOpacity(
                    opacity: isActive ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Text(
                      text,
                      textAlign: .center,
                      style: Pretendard.medium.set(
                        size: 12,
                        height: 1.3,
                        color: ColorStyles.gray60,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Text(
                      text,
                      textAlign: .center,
                      style: Pretendard.medium.set(
                        size: 12,
                        height: 1.3,
                        color: ColorStyles.primary50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
