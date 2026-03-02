import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
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
      appBar: MPBackAppbar(context),
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
                  ? MPButton("시작하기", onTap: () => isIntro.value = false)
                  : MPButton(
                      "다음",
                      onTap: () async {
                        if (step != 2) {
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
