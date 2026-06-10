import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/enum/date_range.dart';
import 'package:mypoly/model/bill.dart';
import 'package:mypoly/module/common/bill/bill_widget.dart';
import 'package:mypoly/module/main/home/bookmark/bookmark_provider.dart';
import 'package:mypoly/module/main/main_provider.dart';
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
    final createdAtRange = ref.watch(createdAtRangeProvider);

    final bookmarksPaging = ref.watch(bookmarksPagingProvider);

    return Scaffold(
      appBar: MPAppBar(context, text: "보관함"),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Container(
            height: 56.h,
            padding: .symmetric(horizontal: 20.w),
            child: Row(
              spacing: 8.w,
              children: [
                MPFilterChip(
                  text: "날짜",
                  isActive: createdAtRange != (MPDateRange.all, null, null),
                  onTap: () => ref
                      .read(createdAtRangeProvider.notifier)
                      .showBottomSheet(context),
                ),
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
          Expanded(
            child: PagedListView(
              padding: .only(top: 10.h),
              state: bookmarksPaging,
              fetchNextPage: ref
                  .read(bookmarksPagingProvider.notifier)
                  .fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<BillListData>(
                itemBuilder: (context, item, index) => BillCompactColumnItem(
                  index: index,
                  item: item,
                  onTap: () {},
                ),
                firstPageProgressIndicatorBuilder: (_) =>
                    Column(children: [MPHeight(180), MPLoading()]),
                firstPageErrorIndicatorBuilder: (_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: .stretch,
                  children: [
                    MPHeight(160),
                    EmptyWidget(
                      message: "문제가 발생했어요",
                      subMessage: "잠시 후 다시 시도해 주세요",
                      buttonText: "보러가기",
                      onTap: ref
                          .read(bookmarksPagingProvider.notifier)
                          .onRefresh,
                    ),
                  ],
                ),
                newPageProgressIndicatorBuilder: (_) => MPSafeBox(
                  bottom: true,
                  child: Center(child: MPLoading(size: 18)),
                ),
                newPageErrorIndicatorBuilder: (_) => const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: .stretch,
                  children: [
                    MPHeight(160),
                    EmptyWidget(
                      image: WebpImage.emptySearch,
                      message: "보관된 안건이 없어요",
                      subMessage: "관심가는 안건을 보관하고 지켜보세요",
                      buttonText: "보러가기",
                      onTap: () {
                        ref.read(mainPageProvider.notifier).update(0);
                        context.pop();
                      },
                    ),
                  ],
                ),
                noMoreItemsIndicatorBuilder: (_) => MPSafeBox(bottom: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
