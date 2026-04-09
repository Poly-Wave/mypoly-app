import 'package:flutter/material.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyInfoButton extends StatelessWidget {
  final (String, String, Color, void Function()) item;

  const MyInfoButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.$4,
      child: Container(
        padding: EdgeInsets.all(1),
        width: 155.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: .circular(10.r),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF2E5C66), Color(0xFF769999)],
          ),
        ),
        child: Container(
          padding: .symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: .circular(10.r),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFA5FFEF).withValues(alpha: 0.1),
                Color(0xFF256D86).withValues(alpha: 0.1),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: .center,
            children: [
              MPSvgImage(item.$2, size: 24),
              SizedBox(width: 8.w),
              Text(
                item.$1,
                style: Pretendard.semiBold.set(
                  size: 16,
                  color: ColorStyles.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
