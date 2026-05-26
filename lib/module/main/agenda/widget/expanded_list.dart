import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/widget/index.dart';

class ExpandedList extends StatelessWidget {
  final List<dynamic> items;
  final VoidCallback onCollapsePressed;

  const ExpandedList({
    super.key,
    required this.items,
    required this.onCollapsePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(items.length, (index) {
              final item = items[index];

              final bool isFirst = index == 0;
              final bool isLast = index == items.length - 1;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isFirst)
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Container(height: 1.h, color: ColorStyles.gray50),
                    ),
                  Container(
                    padding: EdgeInsets.only(
                      top: isFirst ? 0 : 8.h,
                      bottom: isLast ? 0 : 8.h,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        _buildStatusIcon('stable'),
                        SizedBox(width: 4.w),
                        Text(
                          "${item.rank}",
                          style: Pretendard.medium.set(
                            size: 15,
                            color: ColorStyles.white,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Pretendard.medium.set(
                              size: 15,
                              color: ColorStyles.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          item.categoryName ?? '',
                          style: Pretendard.medium.set(
                            size: 13,
                            color: ColorStyles.gray20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),

        GestureDetector(
          onTap: onCollapsePressed,
          behavior: HitTestBehavior.translucent,
          child: Container(
            width: 16.0.w,
            height: 16.h,
            margin: EdgeInsets.only(left: 9.w),
            alignment: Alignment.center,
            child: MPSvgImage(SvgImage.arrowUp, width: 16.w, height: 16.h),
          ),
        ),
      ],
    );
  }
}

Widget _buildStatusIcon(String status) {
  switch (status) {
    case 'up':
      return MPImage(WebpImage.rankUp, width: 12.0, height: 12.0);
    case 'down':
      return MPImage(WebpImage.rankDown, width: 12.0, height: 12.0);
    case 'stable':
    default:
      return MPImage(WebpImage.rankStable, width: 8.2, height: 1.73);
  }
}
