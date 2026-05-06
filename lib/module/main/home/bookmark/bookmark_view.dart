import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/module/main/home/bookmark/bookmark_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class BookmarkView extends HookConsumerWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);
    final categories = ref.watch(categoriesProvider);
    final stages = ref.watch(stagesProvider);

    final bookmarksPaging = ref.watch(bookmarksPagingProvider);

    return Scaffold(
      appBar: MPAppbar(context, text: "보관함"),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Container(
            height: 56.h,
            padding: .symmetric(horizontal: 20.w),
            child: Row(
              spacing: 8.w,
              children: [
                MPFilterChip(text: "날짜", isActive: false, onTap: () {}),
                MPFilterChip(
                  text: "주제",
                  isActive: categories.isNotEmpty,
                  onTap: () => ref
                      .read(categoriesProvider.notifier)
                      .showBottomSheet(context),
                ),
                MPFilterChip(
                  text: "진행단계",
                  isActive: stages.isNotEmpty,
                  onTap: () => ref
                      .read(stagesProvider.notifier)
                      .showBottomSheet(context),
                ),
              ],
            ),
          ),
          Container(
            height: 46.h,
            padding: .symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "보관된 안건",
                  style: Pretendard.semiBold.set(
                    size: 18,
                    color: ColorStyles.gray10,
                  ),
                ),
                MPSortSwitch(
                  value: sort,
                  onChanged: ref.read(sortProvider.notifier).onChanged,
                ),
              ],
            ),
          ),
          Container(height: 1.h, color: ColorStyles.gray80),
        ],
      ),
    );
  }
}
