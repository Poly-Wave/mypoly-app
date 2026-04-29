import 'package:flutter/material.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteAgendaItem extends StatelessWidget {
  const FavoriteAgendaItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112.h,
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: ColorStyles.gray70,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(child: Icon(Icons.image, color: Colors.white24)),
          ),

          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "소득세법 일부개정법률안(대안)(기획재정위원장)",
                  style: Pretendard.medium.set(
                    size: 16,
                    color: ColorStyles.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 12.h),
                Container(
                  width: 61.w,
                  height: 22.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorStyles.primary20,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    "외교안보",
                    style: Pretendard.semiBold.set(
                      size: 13,
                      color: Color(0xFF181B2A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
