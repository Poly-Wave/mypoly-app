import 'package:flutter/material.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteAgendaItem extends StatelessWidget {
  final dynamic item;

  const FavoriteAgendaItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final String title = item.title ?? '';
    final String categoryName = item.categoryName ?? '';
    final String categoryIconUrl = item.categoryIconUrl ?? '';
    final String categoryBgColorStr = item.categoryBackgroundColor ?? '';

    Color parsedCategoryBgColor = ColorStyles.primary20;
    if (categoryBgColorStr.isNotEmpty) {
      try {
        parsedCategoryBgColor = Color(int.parse('0xFF$categoryBgColorStr'));
      } catch (e) {
        debugPrint('관심안건 카테고리 배경색 파싱 실패: $e');
      }
    }

    return SizedBox(
      height: 112.h,
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: parsedCategoryBgColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: SizedBox(
                width: 40.w,
                height: 40.h,
                child: Image(
                  image: NetworkImage(categoryIconUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
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
                    color: parsedCategoryBgColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    categoryName,
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
