import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'register_onboard_provider.dart';

class RegisterOnboardCarouselView extends HookConsumerWidget {
  RegisterOnboardCarouselView({super.key});

  final _steps = [
    (LottieFile.registerOnboard1, "나에게 필요한 정책은 뭘까?\nAI가 찾아서 알려드려요"),
    (LottieFile.registerOnboard2, "의안 찬성 vs 반대!\n투표로 의견을 나눠요"),
    (LottieFile.registerOnboard3, "내 정보를 넣어두고\n알맞는 혜택을 찾아드려요"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(registerOnboardStepProvider);
    final pageController = ref.watch(registerOnboardPageContaollerProvider);
    final textAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(() {
      textAnimationController.reset();
      textAnimationController.forward();
      return null;
    }, [step, textAnimationController]);

    final textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: textAnimationController, curve: Curves.easeOut),
    );

    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      spacing: 24.h,
      children: [
        SizedBox(
          height: 300.h,
          child: PageView(
            controller: pageController,
            onPageChanged: ref
                .read(registerOnboardStepProvider.notifier)
                .update,
            physics: const NeverScrollableScrollPhysics(),
            children: _steps
                .map(
                  (data) => Center(
                    child: Lottie.asset(data.$1, width: 274.w, fit: .fitWidth),
                  ),
                )
                .toList(),
          ),
        ),
        FadeTransition(
          opacity: textOpacityAnimation,
          child: Text(
            _steps[step].$2,
            textAlign: .center,
            style: Pretendard.semiBold.set(
              size: 28,
              height: 1.3,
              letterSpacing: -0.54,
              color: ColorStyles.white,
            ),
          ),
        ),
      ],
    );
  }
}
