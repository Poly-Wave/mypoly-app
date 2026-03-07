import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';

@RoutePage()
class MyInfoView extends HookConsumerWidget {
  const MyInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);

    return Scaffold(
      appBar: MPAppbar(context, text: "내정보"),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: MPSingleScroll(
              child: MPSafeColumn(
                bottom: true,
                crossAxisAlignment: .stretch,
                children: [
                  MPHeight(20),
                  Center(
                    child: Stack(
                      children: [MPImage(WebpImage.emptyProfile, size: 64)],
                    ),
                  ),
                  MPHeight(20),
                  MyInfoGroup(
                    verticalPadding: 24,
                    children: [
                      MyInfoGroupItem(
                        "로그인 방식",
                        subText: "카카오",
                        useArrow: false,
                      ),
                      MyInfoGroupItem(
                        "별명",
                        subText: user?.nickname ?? "",
                        useArrow: false,
                      ),
                      MyInfoGroupItem("성별", subText: "", useArrow: false),
                      MyInfoGroupItem("연령", subText: "", useArrow: false),
                      MyInfoGroupItem("거주지역", subText: "", useArrow: false),
                      MyInfoGroupItem("관심 주제", subText: "5개"),
                    ],
                  ),
                  MPHeight(40),
                  Container(height: 6.h, color: Color(0xFF222324)),
                  MPHeight(40),
                  MyInfoGroup(
                    children: [
                      MyInfoGroupTitle("설정"),
                      MyInfoGroupItem("알림", onTap: () {}),
                      MyInfoGroupItem(
                        "공지사항",
                        onTap: () => context.pushRoute(NoticeRoute()),
                      ),
                      MyInfoGroupItem("고객센터", onTap: () {}),
                      MyInfoGroupItem("탈퇴하기", onTap: () {}),
                      MyInfoGroupItem(
                        "로그아웃",
                        onTap: () => showMPConfirmModal(
                          context,
                          title: "정말 로그아웃 하시겠습니까?",
                          onOkTap: ref.read(appUserProvider.notifier).logout,
                        ),
                      ),
                    ],
                  ),
                  MPHeight(32),
                  MyInfoGroup(
                    children: [
                      MyInfoGroupTitle("앱 정보"),
                      MyInfoGroupItem("앱 버전 정보", onTap: () {}),
                      MyInfoGroupItem(
                        "약관",
                        onTap: () => context.pushRoute(TermRoute()),
                      ),
                      MyInfoGroupItem("오픈소스 라이선스", onTap: () {}),
                    ],
                  ),
                  MPHeight(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyInfoGroup extends StatelessWidget {
  final int verticalPadding;
  final List<Widget> children;

  const MyInfoGroup({
    super.key,
    required this.children,
    this.verticalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .symmetric(horizontal: 20.w),
      padding: .symmetric(vertical: verticalPadding.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: .circular(10.r),
        color: ColorStyles.gray80,
      ),
      child: Column(crossAxisAlignment: .stretch, children: children),
    );
  }
}

class MyInfoGroupTitle extends StatelessWidget {
  final String text;

  const MyInfoGroupTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      alignment: .centerLeft,
      child: Text(
        text,
        style: Pretendard.medium.set(size: 14, color: ColorStyles.gray30),
      ),
    );
  }
}

class MyInfoGroupItem extends StatelessWidget {
  final String text;
  final Widget? subWidget;
  final String? subText;
  final void Function()? onTap;
  final bool useArrow;

  const MyInfoGroupItem(
    this.text, {
    super.key,
    this.subWidget,
    this.subText,
    this.onTap,
    this.useArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 46.h,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: Pretendard.semiBold.set(
                  size: 15,
                  color: ColorStyles.white,
                ),
              ),
            ),
            MPWidth(4),
            if (subWidget != null) ...[
              MPWidth(4),
              subWidget ?? SizedBox.shrink(),
            ],
            if (subText != null) ...[
              MPWidth(4),
              Text(
                subText ?? "",
                style: Pretendard.medium.set(
                  size: 15,
                  color: ColorStyles.gray30,
                ),
              ),
            ],
            if (useArrow) ...[
              MPWidth(4),
              MPSvgImage(SvgImage.arrowRight, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}
