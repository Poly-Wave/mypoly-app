import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/module/main/home/vote/vote_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class VoteView extends HookConsumerWidget {
  const VoteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);
    final voteResult = ref.watch(voteResultProvider);

    return Scaffold(
      appBar: MPAppbar(context, text: "참여 투표"),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Container(
            height: 56.h,
            padding: .symmetric(horizontal: 20.w),
            child: Row(
              spacing: 8.w,
              children: [
                MPFilterChip(text: "생성일", isActive: true, onTap: () {}),
                MPFilterChip(
                  text: "투표결과",
                  isActive: voteResult != null,
                  onTap: () => ref
                      .read(voteResultProvider.notifier)
                      .showBottomSheet(context),
                ),
                MPFilterChip(text: "투표날짜", isActive: false, onTap: () {}),
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
        ],
      ),
    );
  }
}
