import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class RegisterOnboardView extends HookConsumerWidget {
  final String nickname;

  const RegisterOnboardView({super.key, required this.nickname});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MPBackAppbar(context),
      body: MPSafeColumn(
        bottom: true,
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                MPHeight(104),
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
          MPHeight(20),
          Padding(
            padding: .symmetric(horizontal: 20.w),
            child: MPButton(
              "시작하기",
              onTap: () => context.replaceRoute(RegisterTopicRoute()),
            ),
          ),
          MPHeight(20),
        ],
      ),
    );
  }
}
