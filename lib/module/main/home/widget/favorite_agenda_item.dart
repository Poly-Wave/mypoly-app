import 'package:flutter/material.dart';
import 'package:mypoly/model/agenda.dart';
import 'package:mypoly/module/main/widget/agenda.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';

class FavoriteAgendaItem extends StatelessWidget {
  final AgendaListData item;
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
      behavior: .translucent,
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
                    item.title.wrapped,
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
                    child: AgendaCategoryBadge(category: item.category),
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
