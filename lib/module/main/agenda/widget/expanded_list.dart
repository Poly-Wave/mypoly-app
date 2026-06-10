import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/widget/index.dart';

class ExpandedList extends HookWidget {
  final List<dynamic> items;
  final bool isDataChange;
  final VoidCallback onCollapsePressed;

  const ExpandedList({
    super.key,
    required this.items,
    required this.isDataChange,
    required this.onCollapsePressed,
  });

  @override
  Widget build(BuildContext context) {
    const int baseFadeMs = 200;
    const int charIntervalMs = 50;

    List<int> computedRowDelays = [];
    int accumulatedDelay = 0;

    for (int i = 0; i < items.length; i++) {
      computedRowDelays.add(accumulatedDelay);
      final String currentTitle = items[i].title ?? '';

      int rowRunningTime =
          400 + (currentTitle.length * charIntervalMs) + 200 + 150;
      accumulatedDelay += rowRunningTime;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final int rowBaseDelay = computedRowDelays[index];

              final bool isFirst = index == 0;
              final bool isLast = index == items.length - 1;

              final String titleStr = item.title ?? '';
              final String categoryStr = item.categoryName ?? '';

              final int iconDelay = rowBaseDelay + 0;
              final int rankDelay = iconDelay + baseFadeMs;
              final int titleBaseDelay = rankDelay + baseFadeMs;
              final int categoryDelay =
                  titleBaseDelay + (titleStr.length * charIntervalMs);

              return Column(
                key: ValueKey('expanded_row_${item.billId ?? index}'),
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
                        _FadeInWidget(
                          delay: Duration(milliseconds: iconDelay),
                          duration: Duration(milliseconds: baseFadeMs),
                          isDataChange: isDataChange,
                          child: _buildStatusIcon(
                            item.rankChangeType.toString(),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        _FadeInWidget(
                          delay: Duration(milliseconds: rankDelay),
                          duration: Duration(milliseconds: baseFadeMs),
                          isDataChange: isDataChange,
                          child: Text(
                            "${item.rank}",
                            style: Pretendard.medium.set(
                              size: 15,
                              color: ColorStyles.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: SizedBox(
                            width: 189.w,
                            child: Wrap(
                              clipBehavior: Clip.hardEdge,
                              children: List.generate(titleStr.length, (
                                charIndex,
                              ) {
                                final char = titleStr[charIndex];

                                return _FadeInWidget(
                                  char: char,
                                  delay: Duration(
                                    milliseconds:
                                        titleBaseDelay +
                                        (charIndex * charIntervalMs),
                                  ),
                                  duration: Duration(milliseconds: index * 50),
                                  isDataChange: isDataChange,
                                );
                              }),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        _FadeInWidget(
                          delay: Duration(milliseconds: categoryDelay),
                          duration: Duration(milliseconds: baseFadeMs),
                          isDataChange: isDataChange,
                          child: Text(
                            categoryStr,
                            style: Pretendard.medium.set(
                              size: 13,
                              color: ColorStyles.gray20,
                            ),
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

class _FadeInWidget extends HookWidget {
  final Widget? child;
  final String? char;
  final Duration delay;
  final Duration duration;
  final bool isDataChange;

  const _FadeInWidget({
    super.key,
    this.child,
    this.char,
    required this.delay,
    required this.duration,
    required this.isDataChange,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(
      '#################_FadeInWidget isDataChange: $isDataChange.value',
    );
    if (!isDataChange) {
      return char != null
          ? Text(
              char!,
              style: Pretendard.medium.set(size: 15, color: Colors.white),
            )
          : child!;
    }

    final opacity = useState(0.0);

    useEffect(() {
      final timer = Future.delayed(delay, () {
        if (context.mounted) {
          opacity.value = 1.0;
        }
      });
      return null;
    }, []);

    return AnimatedOpacity(
      duration: duration,
      curve: Curves.linear,
      opacity: opacity.value,
      child: char != null
          ? Text(
              char!,
              style: Pretendard.medium.set(size: 15, color: Colors.white),
            )
          : child,
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
