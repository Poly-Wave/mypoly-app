import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class OnboardView extends HookConsumerWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FlutterNativeSplash.remove();
      });

      return null;
    }, []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: .symmetric(horizontal: 20.w),
        child: MPSafeColumn(
          top: true,
          bottom: true,
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .stretch,
                spacing: 24.h,
                children: [
                  Center(
                    child: MPSvgImage(
                      SvgImage.logo,
                      width: 140,
                      fit: .fitWidth,
                    ),
                  ),
                  Text(
                    "나에게 맞는 정책을\n핵심만 투명하고 간편하게",
                    textAlign: .center,
                    style: Pretendard.semiBold.set(
                      size: 18,
                      height: 1.4,
                      color: ColorStyles.primary10,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: .stretch,
              spacing: 12.h,
              children: [
                ("카카오로 로그인", SvgImage.socialKakao, Color(0xFFFFDF00), () {}),
                ("애플로 로그인", SvgImage.socialApple, ColorStyles.white, () {}),
                ("구글로 로그인", SvgImage.socialGoogle, ColorStyles.white, () {}),
              ].map((item) => OnboardButton(item: item)).toList(),
            ),
            MPHeight(50),
          ],
        ),
      ),
    );
  }
}

class OnboardButton extends StatelessWidget {
  final (String, String, Color, void Function()) item;

  const OnboardButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.$4,
      child: Container(
        height: 53.h,
        decoration: BoxDecoration(
          borderRadius: .circular(12.r),
          color: item.$3,
        ),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 10.w,
          children: [
            MPSvgImage(item.$2, size: 24),
            Text(
              item.$1,
              style: Pretendard.semiBold.set(
                size: 18,
                color: ColorStyles.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
