import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/style/index.dart';

class CarouselIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final double spacing;

  const CarouselIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool isActive = index == currentIndex;

        return AnimatedContainer(
          width: 8.r,
          height: 8.r,
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          margin: EdgeInsets.only(right: index == count - 1 ? 0 : 10.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? ColorStyles.primary50 : ColorStyles.gray70,
          ),
        );
      }),
    );
  }
}
