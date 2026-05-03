import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class BookmarkView extends HookConsumerWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MPAppbar(context, text: "보관함"),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Container(
            height: 56.h,
            padding: .symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                MPFilterChip(text: "날짜", isActive: false, onTap: () {}),
                MPFilterChip(text: "지역", isActive: false, onTap: () {}),
                MPFilterChip(text: "주제", isActive: false, onTap: () {}),
                MPFilterChip(text: "진행단계", isActive: false, onTap: () {}),
              ],
            ),
          ),
          Container(height: 46.h),
        ],
      ),
    );
  }
}
