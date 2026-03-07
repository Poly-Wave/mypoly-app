import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class RegisterCompleteView extends HookConsumerWidget {
  const RegisterCompleteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: MPAppbar(context, isBackEnabled: false),
        body: MPSafeColumn(
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
                    child: MPImage(
                      WebpImage.registerComplete,
                      width: 274,
                      fit: .fitWidth,
                    ),
                  ),
                  Text(
                    "환영해요 🙌\n이제 편하게 즐겨보세요!",
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
            MPHeight(20),
            Padding(
              padding: .symmetric(horizontal: 20.w),
              child: MPButton(
                "시작하기",
                onTap: () => context.replaceRoute(MainRoute()),
              ),
            ),
            MPHeight(20),
          ],
        ),
      ),
    );
  }
}
