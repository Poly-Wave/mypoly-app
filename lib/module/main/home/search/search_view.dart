import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/model/bill.dart';
import 'package:mypoly/module/common/bill/bill_widget.dart';
import 'package:mypoly/module/main/home/search/search_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appKeywords = ref.watch(appKeywordsProvider);
    final lastKeyword = ref.watch(lastKeywordProvider);

    final searchPaging = ref.watch(searchPagingProvider);

    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: SearchAppBar(context),
        body: Column(
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: MPCustomScroll(
                slivers: [
                  if (searchPaging != null)
                    PagedSliverList(
                      state: searchPaging,
                      fetchNextPage: ref
                          .read(searchPagingProvider.notifier)
                          .fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate<BillListData>(
                        itemBuilder: (context, item, index) =>
                            BillCompactColumnItem(
                              index: index,
                              item: item,
                              onTap: () {},
                            ),
                        firstPageProgressIndicatorBuilder: (_) =>
                            Column(children: [MPHeight(271), MPLoading()]),
                        firstPageErrorIndicatorBuilder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: .stretch,
                          children: [
                            MPHeight(256),
                            EmptyWidget(
                              message: "문제가 발생했어요",
                              subMessage: "잠시 후 다시 시도해 주세요",
                              buttonText: "보러가기",
                              onTap: ref
                                  .read(searchPagingProvider.notifier)
                                  .onRefresh,
                            ),
                          ],
                        ),
                        newPageProgressIndicatorBuilder: (_) => MPSafeBox(
                          bottom: true,
                          child: Center(child: MPLoading(size: 18)),
                        ),
                        newPageErrorIndicatorBuilder: (_) =>
                            const SizedBox.shrink(),
                        noItemsFoundIndicatorBuilder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MPHeight(267),
                            Text(
                              "‘$lastKeyword‘에 대한\n결과가 없어요",
                              textAlign: .center,
                              style: Pretendard.semiBold.set(
                                size: 18,
                                height: 1.4,
                                color: ColorStyles.white,
                              ),
                            ),
                            MPHeight(8),
                            Text(
                              "다른 검색어로 다시 시도해 보세요",
                              textAlign: .center,
                              style: Pretendard.medium.set(
                                size: 15,
                                height: 1.45,
                                color: ColorStyles.gray30,
                              ),
                            ),
                          ],
                        ),
                        noMoreItemsIndicatorBuilder: (_) =>
                            MPSafeBox(bottom: true),
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          Container(
                            height: 46.h,
                            padding: .symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text(
                                  "최근 검색",
                                  style: Pretendard.medium.set(
                                    size: 15,
                                    color: ColorStyles.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: ref
                                      .read(appKeywordsProvider.notifier)
                                      .reset,
                                  child: Text(
                                    "전체 삭제",
                                    style: Pretendard.medium.set(
                                      size: 14,
                                      color: ColorStyles.gray30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (appKeywords.isEmpty) ...[
                            MPHeight(271),
                            Text(
                              "검색 내역이 없어요.",
                              textAlign: .center,
                              style: Pretendard.medium.set(
                                size: 15,
                                height: 1.45,
                                color: ColorStyles.gray30,
                              ),
                            ),
                          ] else
                            ...appKeywords.map(
                              (keyword) => SearchKeywordItem(
                                text: keyword,
                                onTap: () => ref
                                    .read(keywordProvider.notifier)
                                    .onSet(keyword),
                                onDeleteTap: () => ref
                                    .read(appKeywordsProvider.notifier)
                                    .delete(keyword),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final BuildContext context;

  const SearchAppBar(this.context, {super.key});

  @override
  Size get preferredSize =>
      Size(double.infinity, MediaQuery.of(context).padding.top + 59.h);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyword = ref.watch(keywordProvider);

    return Container(
      color: ColorStyles.black,
      child: MPSafeBox(
        top: true,
        child: Container(
          height: 59.h,
          padding: .symmetric(horizontal: 20.w),
          child: Row(
            spacing: 4.w,
            children: [
              GestureDetector(
                onTap: context.maybePop,
                child: MPSvgImage(SvgImage.icBack, size: 32),
              ),
              Expanded(
                child: MPInput(
                  contentPadding: .symmetric(
                    vertical: 13.5.h,
                    horizontal: 16.w,
                  ),
                  hintText: "검색",
                  controller: ref.read(keywordProvider.notifier).controller,
                  focusNode: ref.read(keywordProvider.notifier).focusNode,
                  onSubmitted: ref.read(keywordProvider.notifier).onSubmitted,
                  innerRight: Row(
                    mainAxisSize: .min,
                    mainAxisAlignment: .end,
                    children: [
                      if (keyword.isNotEmpty) ...[
                        GestureDetector(
                          onTap: ref.read(keywordProvider.notifier).onReset,
                          child: MPSvgImage(SvgImage.icReset, size: 24),
                        ),
                      ],
                      MPWidth(16),
                    ],
                  ),
                  innerRightConstraints: .tightForFinite(
                    width: (keyword.isNotEmpty ? 24.r : 0) + 16.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchKeywordItem extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final void Function() onDeleteTap;

  const SearchKeywordItem({
    super.key,
    required this.text,
    required this.onTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: .translucent,
      child: Container(
        height: 46.h,
        padding: .symmetric(horizontal: 20.w),
        child: Row(
          spacing: 12.w,
          children: [
            MPSvgImage(SvgImage.icSearchClock, size: 16),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: .ellipsis,
                style: Pretendard.medium.set(
                  size: 15,
                  color: ColorStyles.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: onDeleteTap,
              child: MPSvgImage(SvgImage.icSearchClose, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
