import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/util/event.dart';
import 'package:mypoly/widget/index.dart';
import 'register_onboard_intro_view.dart';
import 'register_onboard_carousel_view.dart';
import 'register_onboard_provider.dart';

@RoutePage()
class RegisterOnboardView extends HookConsumerWidget {
  const RegisterOnboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FlutterNativeSplash.remove();

        Event.send(name: "onboarding_1_pv");
      });

      return null;
    }, []);

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
      appBar: MPAppBar(context, isBackEnabled: false),
      body: MPSafeColumn(
        bottom: true,
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: switch (isIntro.value) {
              true => RegisterOnboardIntroView(
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
                  ? MPButton(
                      "시작하기",
                      onTap: () {
                        Event.send(name: "onboarding_1_start_btn_click");
                        Event.send(name: "onboarding_2-1_pv");
                        isIntro.value = false;
                      },
                    )
                  : MPButton(
                      "다음",
                      onTap: () async {
                        Event.send(
                          name: "onboarding_2-${step + 1}_next_btn_click",
                        );

                        if (step != 2) {
                          Event.send(name: "onboarding_2-${step + 2}_pv");

                          pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                          return;
                        }

                        context.loaderOverlay.show();

                        try {
                          await ref
                              .read(userServiceProvider)
                              .updateOnboardStatus(.onboarding);

                          if (!context.mounted) return;
                          context.loaderOverlay.hide();
                          context.replaceRoute(RegisterTopicRoute());
                        } catch (e) {
                          context.loaderOverlay.hide();
                          context.replaceRoute(RegisterTopicRoute());
                        }
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
