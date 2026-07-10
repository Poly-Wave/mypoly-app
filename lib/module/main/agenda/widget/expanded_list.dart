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
    List<int> computedRowDelays = [];
    int accumulatedDelay = 100;

    for (int i = 0; i < items.length; i++) {
      computedRowDelays.add(accumulatedDelay);

      final String titleStr = items[i].headline ?? items[i].title ?? '';
      final int lastCharDelay = titleStr.isEmpty
          ? 0
          : (titleStr.length - 1) * 50;
      final int rowTotalTime = lastCharDelay + 250 + 250 + 300;

      accumulatedDelay += rowTotalTime;
    }

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

              final int rowDelayMs = isDataChange
                  ? computedRowDelays[index]
                  : 0;

              return Column(
                key: ValueKey('expanded_fixed_row_$index'),
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
                    child: _SequentialRowSwitcher(
                      index: index,
                      item: item,
                      delay: Duration(milliseconds: rowDelayMs),
                      isDataChange: isDataChange,
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

class _SequentialRowSwitcher extends HookWidget {
  final int index;
  final dynamic item;
  final Duration delay;
  final bool isDataChange;

  const _SequentialRowSwitcher({
    required this.index,
    required this.item,
    required this.delay,
    required this.isDataChange,
  });

  @override
  Widget build(BuildContext context) {
    final currentItem = useState(item);
    final hasItemChanged = useState(false);

    useEffect(() {
      if (currentItem.value.billId != item.billId) {
        if (!isDataChange) {
          currentItem.value = item;
          return null;
        }

        hasItemChanged.value = true;
        final timer = Future.delayed(delay, () {
          if (context.mounted) {
            currentItem.value = item;
          }
        });
      }
      return null;
    }, [item.billId, isDataChange]);

    final String titleStr =
        currentItem.value.headline ?? currentItem.value.title ?? '';
    final String categoryStr = currentItem.value.categoryName ?? '';

    final int lastCharDelayTime = titleStr.isEmpty
        ? 0
        : (titleStr.length - 1) * 50;
    final bool triggerAnim = isDataChange && hasItemChanged.value;
    final int categoryDelayMs = isDataChange ? (lastCharDelayTime + 250) : 0;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Row(
        key: ValueKey('row_content_${currentItem.value.billId}'),
        children: [
          _buildStatusIcon(currentItem.value.rankChangeType.toString()),
          SizedBox(width: 4.w),
          Text(
            "${currentItem.value.rank}",
            style: Pretendard.medium.set(size: 15, color: ColorStyles.white),
          ),
          SizedBox(width: 6.w),

          Expanded(
            child: SizedBox(
              width: 189.w,
              child: Text.rich(
                TextSpan(
                  children: List.generate(titleStr.length, (charIndex) {
                    final char = titleStr[charIndex];
                    final int charDelay = triggerAnim ? (charIndex * 50) : 0;

                    return WidgetSpan(
                      child: _TypingCharWidget(
                        key: ValueKey(
                          'char_${currentItem.value.billId}_${charIndex}_$char',
                        ),
                        char: char,
                        delay: Duration(milliseconds: charDelay),
                      ),
                    );
                  }),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(width: 6.w),

          _CategoryFadeWidget(
            key: ValueKey('category_${currentItem.value.billId}_$categoryStr'),
            categoryName: categoryStr,
            delay: Duration(milliseconds: categoryDelayMs),
          ),
        ],
      ),
    );
  }
}

class _TypingCharWidget extends HookWidget {
  final String char;
  final Duration delay;

  const _TypingCharWidget({super.key, required this.char, required this.delay});

  @override
  Widget build(BuildContext context) {
    final opacity = useState(0.0);

    useEffect(() {
      if (delay == Duration.zero) {
        opacity.value = 1.0;
        return null;
      }

      final timer = Future.delayed(delay, () {
        if (context.mounted) {
          opacity.value = 1.0;
        }
      });
      return null;
    }, []);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
      opacity: opacity.value,
      child: Text(
        char,
        style: Pretendard.medium.set(size: 15, color: Colors.white),
      ),
    );
  }
}

class _CategoryFadeWidget extends HookWidget {
  final String categoryName;
  final Duration delay;

  const _CategoryFadeWidget({
    super.key,
    required this.categoryName,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = useState(0.0);

    useEffect(() {
      if (delay == Duration.zero) {
        opacity.value = 1.0;
        return null;
      }

      final timer = Future.delayed(delay, () {
        if (context.mounted) {
          opacity.value = 1.0;
        }
      });
      return null;
    }, []);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
      opacity: opacity.value,
      child: Text(
        categoryName,
        style: Pretendard.medium.set(size: 13, color: ColorStyles.gray20),
      ),
    );
  }
}

Widget _buildStatusIcon(String status) {
  if (status.contains('up') || status.contains('UP')) {
    return MPImage(WebpImage.rankUp, width: 12.0, height: 12.0);
  } else if (status.contains('down') || status.contains('DOWN')) {
    return MPImage(WebpImage.rankDown, width: 12.0, height: 12.0);
  } else {
    return MPImage(WebpImage.rankStable, width: 8.2, height: 1.73);
  }
}
