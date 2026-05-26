import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final int currentIndex;

  const MainAppBar(this.context, {super.key, required this.currentIndex});

  @override
  Size get preferredSize =>
      Size(double.infinity, MediaQuery.of(context).padding.top + 59.h);

  String get title {
    switch (currentIndex) {
      case 0:
        return '안건';
      case 1:
        return '홈';
      case 2:
        return '보조금';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.black,
      child: MPSafeBox(
        top: true,
        child: Container(
          height: 59.h,
          padding: .symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                title,
                style: Pretendard.semiBold.set(
                  size: 24,
                  color: ColorStyles.white,
                ),
              ),
              Row(
                spacing: 8.w,
                children: [
                  GestureDetector(
                    onTap: () => context.pushRoute(SearchRoute()),
                    child: MPSvgImage(
                      SvgImage.icSearch,
                      size: 32,
                      color: ColorStyles.gray20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pushRoute(NotificationRoute()),
                    child: MPSvgImage(
                      SvgImage.icNotification,
                      size: 32,
                      color: ColorStyles.gray20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
