import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class RegisterOnboardIntroView extends HookWidget {
  final String nickname;
  final VoidCallback onStartTap;

  const RegisterOnboardIntroView({
    super.key,
    required this.nickname,
    required this.onStartTap,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 200), () {
        animationController.forward();
      });
      return null;
    }, [animationController]);

    final offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        );

    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          spacing: 24.h,
          children: [
            Center(
              child: MPImage(
                WebpImage.registerOnboard1,
                width: 274,
                fit: .fitWidth,
              ),
            ),
            Text(
              "만나서 반가워요!\n$nickname님",
              textAlign: .center,
              style: Pretendard.semiBold.set(
                size: 28,
                height: 1.3,
                letterSpacing: -0.54,
                color: ColorStyles.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
