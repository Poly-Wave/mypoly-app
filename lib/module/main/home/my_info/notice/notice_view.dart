import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class NoticeView extends HookConsumerWidget {
  const NoticeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MPAppBar(context, text: "공지사항"),
      body: ListView.separated(
        itemCount: 3,
        padding: .zero,
        separatorBuilder: (context, index) => Container(
          margin: .symmetric(vertical: 4.h, horizontal: 20.w),
          height: 1.h,
          color: ColorStyles.divider,
        ),
        itemBuilder: (context, index) {
          final child = NoticeItem(
            onTap: () => context.pushRoute(NoticeDetailRoute()),
          );

          if (index == 2) {
            return MPSafeBox(bottom: true, child: child);
          }

          return child;
        },
      ),
    );
  }
}

class NoticeItem extends StatelessWidget {
  final void Function() onTap;

  const NoticeItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: .symmetric(horizontal: 20.w),
        height: 92.h,
        child: Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: Column(
                spacing: 4.h,
                mainAxisAlignment: .center,
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    "[공지] 공지내용이 들어가는 자리입니다. 최대 2줄 가능합니다.",
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: Pretendard.semiBold.set(
                      size: 15,
                      height: 1.45,
                      color: ColorStyles.white,
                    ),
                  ),
                  Text(
                    "2025.12.30",
                    style: Pretendard.regular.set(
                      size: 14,
                      height: 1.45,
                      color: ColorStyles.gray30,
                    ),
                  ),
                ],
              ),
            ),
            MPSvgImage(SvgImage.arrowRight, size: 18),
          ],
        ),
      ),
    );
  }
}
