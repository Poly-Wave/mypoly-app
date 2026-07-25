import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class MainFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final MPSort sort;
  final List<CategoryResponse> categories;
  final String categoryText;
  final void Function(MPSort) onSortChanged;
  final void Function() onCategoryTap;

  MainFilterHeaderDelegate({
    required this.sort,
    required this.categories,
    required this.categoryText,
    required this.onSortChanged,
    required this.onCategoryTap,
  });

  @override
  double get minExtent => 113.h;

  @override
  double get maxExtent => 113.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: ColorStyles.black,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Container(
            height: 47.h,
            padding: .symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "의안리스트",
                  style: Pretendard.semiBold.set(
                    size: 20,
                    color: ColorStyles.gray10,
                  ),
                ),
                MPSortSwitch(value: sort, onChanged: onSortChanged),
              ],
            ),
          ),
          Container(
            height: 56.h,
            padding: .symmetric(horizontal: 20.w),
            child: Row(
              spacing: 8.w,
              children: [
                MPFilterChip(
                  text: categoryText,
                  isActive: categories.isNotEmpty,
                  onTap: onCategoryTap,
                ),
              ],
            ),
          ),
          Container(height: 10.h, color: ColorStyles.gray80),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
