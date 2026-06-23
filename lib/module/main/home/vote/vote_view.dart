import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/enum/date_range.dart';
import 'package:mypoly/model/agenda.dart';
import 'package:mypoly/module/main/widget/agenda.dart';
import 'package:mypoly/module/main/widget/list.dart';
import 'package:mypoly/module/main/home/vote/vote_provider.dart';
import 'package:mypoly/module/main/main_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class VoteView extends HookConsumerWidget {
  const VoteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);
    final createdAtRange = ref.watch(createdAtRangeProvider);
    final votedAtRange = ref.watch(votedAtRangeProvider);
    final voteResult = ref.watch(voteResultProvider);

    final votesPaging = ref.watch(votesPagingProvider);

    return Scaffold(
      appBar: MPAppBar(context, text: "참여 투표"),
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
                  text: "생성일",
                  isActive: createdAtRange != (MPDateRange.all, null, null),
                  onTap: () => ref
                      .read(createdAtRangeProvider.notifier)
                      .showBottomSheet(context),
                ),
                MPFilterChip(
                  text: "투표결과",
                  isActive: voteResult != null,
                  onTap: () => ref
                      .read(voteResultProvider.notifier)
                      .showBottomSheet(context),
                ),
                MPFilterChip(
                  text: "투표날짜",
                  isActive: votedAtRange != (MPDateRange.all, null, null),
                  onTap: () => ref
                      .read(votedAtRangeProvider.notifier)
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
                  "참여한 투표",
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
              state: votesPaging,
              fetchNextPage: ref
                  .read(votesPagingProvider.notifier)
                  .fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<AgendaListData>(
                itemBuilder: (context, item, index) => AgendaCompactColumnItem(
                  index: index,
                  item: item,
                  onTap: () =>
                      context.pushRoute(AgendaDetailRoute(id: item.id)),
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
                      onTap: ref.read(votesPagingProvider.notifier).onRefresh,
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
                      message: "참여한 투표가 없어요",
                      subMessage: "투표에 참여하고\n나에게 맞는 안건을 모아보세요",
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
