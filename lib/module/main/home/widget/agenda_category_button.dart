import 'package:flutter/material.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgendaCategoryButton extends StatelessWidget {
  final (String, bool) item;

  const AgendaCategoryButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 32.h,
        padding: .symmetric(horizontal: 12.w, vertical: 6.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: .circular(99.r),
          border: Border.all(
            color: item.$2 ? ColorStyles.primary50 : ColorStyles.gray60,
          ),
        ),
        child: Text(
          item.$1,
          maxLines: 1,
          softWrap: false,
          style: Pretendard.medium.set(
            size: 13,
            color: item.$2 ? ColorStyles.primary60 : ColorStyles.gray20,
          ),
        ),
      ),
    );
  }
}
