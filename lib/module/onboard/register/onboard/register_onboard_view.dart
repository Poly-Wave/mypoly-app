import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/widget/index.dart';
import 'register_onboard_intro_view.dart';
import 'register_onboard_carousel_view.dart';
import 'register_onboard_provider.dart';

@RoutePage()
class RegisterOnboardView extends HookConsumerWidget {
  final String nickname;

  const RegisterOnboardView({super.key, required this.nickname});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIntro = useState(true);
    final step = ref.watch(registerOnboardStepProvider);
    final pageController = ref.watch(registerOnboardPageContaollerProvider);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 200), () {
        animationController.forward();
      });
      return null;
    }, [animationController]);

    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    return Scaffold(
      appBar: MPBackAppbar(context),
      body: MPSafeColumn(
        bottom: true,
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: switch (isIntro.value) {
              true => RegisterOnboardIntroView(
                nickname: nickname,
                onStartTap: () => isIntro.value = false,
              ),
              false => RegisterOnboardCarouselView(),
            },
          ),
          MPHeight(20),
          FadeTransition(
            opacity: opacityAnimation,
            child: Padding(
              padding: .symmetric(horizontal: 20.w),
              child: isIntro.value
                  ? MPButton("시작하기", onTap: () => isIntro.value = false)
                  : MPButton(
                      "다음",
                      onTap: () {
                        if (step != 2) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                          return;
                        }

                        context.replaceRoute(RegisterTopicRoute());
                      },
                    ),
            ),
          ),
          MPHeight(20),
        ],
      ),
    );
  }
}
