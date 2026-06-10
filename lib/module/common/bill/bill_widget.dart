import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/model/bill.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';

class BillCompactColumnItem extends StatelessWidget {
  final int index;
  final BillListData item;
  final void Function() onTap;

  const BillCompactColumnItem({
    super.key,
    required this.index,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        if (index != 0)
          Container(
            height: 1.h,
            margin: .symmetric(horizontal: 20.w),
            color: ColorStyles.gray80,
          ),
        GestureDetector(
          onTap: onTap,
          behavior: .translucent,
          child: Padding(
            padding: .symmetric(vertical: 16.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Align(
                  alignment: .centerLeft,
                  child: BillCategoryBadge(category: item.category),
                ),
                MPHeight(4),
                Text(
                  item.title.wrapped,
                  maxLines: 2,
                  overflow: .ellipsis,
                  style: Pretendard.medium.set(
                    size: 16,
                    height: 1.45,
                    color: ColorStyles.white,
                  ),
                ),
                MPHeight(12),
                Row(
                  children: [
                    Text(
                      item.registeredDate.toDotYMD,
                      style: Pretendard.medium.set(
                        size: 13,
                        height: 1.4,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    Spacer(),
                    MPSvgImage(SvgImage.icCountView, size: 16),
                    MPWidth(2),
                    Text(
                      "${item.viewCount}",
                      style: Pretendard.medium.set(
                        size: 13,
                        height: 1.4,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    MPWidth(8),
                    MPSvgImage(SvgImage.icVoteView, size: 16),
                    MPWidth(2),
                    Text(
                      "${item.voteCount}",
                      style: Pretendard.medium.set(
                        size: 13,
                        height: 1.4,
                        color: ColorStyles.gray30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BillColumnItem extends StatelessWidget {
  final int index;
  final BillListData item;
  final void Function() onTap;

  const BillColumnItem({
    super.key,
    required this.index,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        if (index != 0)
          Container(
            height: 1.h,
            margin: .symmetric(vertical: 6.h, horizontal: 20.w),
            color: ColorStyles.gray80,
          ),
        GestureDetector(
          onTap: onTap,
          behavior: .translucent,
          child: Padding(
            padding: .symmetric(vertical: 16.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  spacing: 12.w,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          Align(
                            alignment: .centerLeft,
                            child: BillCategoryBadge(category: item.category),
                          ),
                          MPHeight(4),
                          Text(
                            item.title.wrapped,
                            maxLines: 2,
                            overflow: .ellipsis,
                            style: Pretendard.medium.set(
                              size: 16,
                              height: 1.45,
                              color: ColorStyles.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 64.r,
                      width: 64.r,
                      decoration: BoxDecoration(
                        borderRadius: .circular(8.r),
                        color: item.category.colorBackground,
                      ),
                      alignment: .center,
                      child: MPNetworkImage(item.category.iconUrl, size: 32),
                    ),
                  ],
                ),
                MPHeight(12),
                Row(
                  children: [
                    Text(
                      item.registeredDate.toDotYMD,
                      style: Pretendard.medium.set(
                        size: 13,
                        height: 1.4,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    Spacer(),
                    MPSvgImage(SvgImage.icCountView, size: 16),
                    MPWidth(2),
                    Text(
                      "${item.viewCount}",
                      style: Pretendard.medium.set(
                        size: 13,
                        height: 1.4,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    MPWidth(8),
                    MPSvgImage(SvgImage.icVoteView, size: 16),
                    MPWidth(2),
                    Text(
                      "${item.voteCount}",
                      style: Pretendard.medium.set(
                        size: 13,
                        height: 1.4,
                        color: ColorStyles.gray30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BillCategoryBadge extends StatelessWidget {
  final CategoryResponse category;

  const BillCategoryBadge({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      padding: .symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: category.colorBadgeBackground,
        borderRadius: .circular(999.r),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Text(
            category.name,
            style: Pretendard.semiBold.set(
              size: 13,
              color: category.colorBadgeTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  final String? image;
  final String message;
  final String subMessage;
  final String buttonText;
  final void Function() onTap;

  const EmptyWidget({
    super.key,
    this.image,
    required this.message,
    required this.subMessage,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: .stretch,
      children: [
        if (image != null) ...[
          Center(child: MPImage(image ?? "", size: 64)),
          MPHeight(10),
        ],
        Text(
          message,
          textAlign: .center,
          style: Pretendard.semiBold.set(
            size: 18,
            height: 1.4,
            color: ColorStyles.white,
          ),
        ),
        MPHeight(8),
        Text(
          subMessage,
          textAlign: .center,
          style: Pretendard.medium.set(
            size: 15,
            height: 1.45,
            color: ColorStyles.gray30,
          ),
        ),
        MPHeight(20),
        Center(
          child: MPButton(
            buttonText,
            style: .line,
            height: 38,
            padding: .symmetric(horizontal: 14.w),
            borderRadius: .circular(8.r),
            textStyle: Pretendard.semiBold.set(
              size: 15,
              color: ColorStyles.white,
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
