import 'package:flutter/material.dart';
import 'package:mypoly/model/bill.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';

class FavoriteAgendaItem extends StatelessWidget {
  final BillListData item;
  final void Function() onTap;

  const FavoriteAgendaItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 112.h,
        child: Row(
          spacing: 12.w,
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: item.category.colorBackground,
                borderRadius: .circular(8.r),
              ),
              child: Center(
                child: MPNetworkImage(item.category.iconUrl, size: 40),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .stretch,
                mainAxisAlignment: .center,
                spacing: 12.h,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: Pretendard.medium.set(
                      size: 16,
                      height: 1.45,
                      color: ColorStyles.white,
                    ),
                  ),
                  Align(
                    alignment: .centerLeft,
                    child: Container(
                      height: 22.h,
                      padding: .symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: item.category.colorBadgeBackground,
                        borderRadius: .circular(999.r),
                      ),
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Text(
                            item.category.name,
                            style: Pretendard.semiBold.set(
                              size: 13,
                              color: item.category.colorBadgeTextColor,
                            ),
                          ),
                        ],
                      ),
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
