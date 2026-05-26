import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/widget/index.dart';

class CollapsedRow extends StatelessWidget {
  final dynamic item;
  final VoidCallback onExpandPressed;

  const CollapsedRow({
    super.key,
    required this.item,
    required this.onExpandPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatusIcon('stable'),
        SizedBox(width: 4.w),
        Text(
          "${item.rank}",
          style: Pretendard.medium.set(size: 15, color: ColorStyles.white),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: SizedBox(
              key: ValueKey<int>(item.rank),
              width: 189.w,
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Pretendard.medium.set(
                  size: 15,
                  color: ColorStyles.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6.w),
        SizedBox(
          child: Text(
            item.categoryName,
            maxLines: 1,
            style: Pretendard.medium.set(size: 13, color: ColorStyles.gray20),
          ),
        ),
        SizedBox(width: 21.w),
        GestureDetector(
          onTap: onExpandPressed,
          child: MPSvgImage(SvgImage.arrowDown, width: 16.0, height: 16.0),
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
