import 'package:flutter/material.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SortButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 20.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? ColorStyles.primary20 : ColorStyles.divider,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          label,
          style: Pretendard.semiBold.set(
            size: 12,
            color: isSelected ? ColorStyles.gray70 : ColorStyles.gray40,
          ),
        ),
      ),
    );
  }
}
