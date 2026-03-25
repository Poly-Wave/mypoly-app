import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class MainBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MainBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyles.black,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.r,
            offset: Offset(0, -4.h),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: MPSafeBox(
        bottom: true,
        child: SizedBox(
          height: 59.h,
          child: Row(
            children: [
              MainNavItem(
                onTap: () => onTap(0),
                isActive: currentIndex == 0,
                text: "안건",
                image: SvgImage.mainAgenda,
              ),
              MainNavItem(
                onTap: () => onTap(1),
                isActive: currentIndex == 1,
                text: "홈",
                image: SvgImage.mainHome,
              ),
              MainNavItem(
                onTap: () => onTap(2),
                isActive: currentIndex == 2,
                text: "보조금",
                image: SvgImage.mainSubsidy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainNavItem extends StatelessWidget {
  final void Function() onTap;
  final bool isActive;
  final String text;
  final String image;

  const MainNavItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: .stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 3.h,
            children: [
              Center(
                child: Stack(
                  alignment: .center,
                  children: [
                    AnimatedOpacity(
                      opacity: isActive ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: MPSvgImage(
                        image,
                        size: 28,
                        color: ColorStyles.gray60,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: isActive ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: MPSvgImage(
                        image,
                        size: 28,
                        color: ColorStyles.primary50,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: .center,
                children: [
                  AnimatedOpacity(
                    opacity: isActive ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Text(
                      text,
                      textAlign: .center,
                      style: Pretendard.medium.set(
                        size: 12,
                        height: 1.3,
                        color: ColorStyles.gray60,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Text(
                      text,
                      textAlign: .center,
                      style: Pretendard.medium.set(
                        size: 12,
                        height: 1.3,
                        color: ColorStyles.primary50,
                      ),
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
