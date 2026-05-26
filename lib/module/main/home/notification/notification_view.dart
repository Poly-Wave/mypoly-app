import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class NotificationView extends HookConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MPAppBar(context, text: "알림"),
      body: ListView.builder(
        itemCount: 3,
        padding: .zero,
        itemBuilder: (context, index) {
          final child = Padding(
            padding: .only(top: 10.h),
            child: NotificationItem(onTap: () {}),
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

class NotificationItem extends StatelessWidget {
  final void Function() onTap;

  const NotificationItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: .symmetric(horizontal: 20.w),
        height: 71.h,
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 4.h,
          children: [
            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: Text(
                    "공지사항",
                    style: Pretendard.regular.set(
                      size: 14,
                      height: 1.45,
                      color: ColorStyles.gray30,
                    ),
                  ),
                ),
                Text(
                  "YYYY.MM.DD",
                  style: Pretendard.medium.set(
                    size: 13,
                    height: 1.4,
                    color: ColorStyles.gray30,
                  ),
                ),
              ],
            ),
            Text(
              "북마크한 보조금 신청기간입니다",
              maxLines: 1,
              overflow: .ellipsis,
              style: Pretendard.medium.set(
                size: 16,
                height: 1.45,
                color: ColorStyles.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
