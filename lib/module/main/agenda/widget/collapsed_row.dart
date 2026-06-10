import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/widget/index.dart';

class CollapsedRow extends HookWidget {
  final dynamic item;
  final bool isDataChange;
  final VoidCallback onExpandPressed;

  const CollapsedRow({
    super.key,
    required this.item,
    required this.isDataChange,
    required this.onExpandPressed,
  });

  @override
  Widget build(BuildContext context) {
    final animationTrigger = useState(0);

    useEffect(() {
      animationTrigger.value = item.rank;
      return null;
    }, [item.rank]);

    final String titleStr = item.title ?? '';
    final String categoryStr = item.categoryName ?? '';

    const int baseFadeMs = 200;
    const int charIntervalMs = 50;

    final int iconDelay = 0;
    final int rankDelay = iconDelay + baseFadeMs;
    final int titleBaseDelay = rankDelay + baseFadeMs;
    final int categoryDelay =
        titleBaseDelay + (titleStr.length * charIntervalMs);

    return Row(
      children: [
        _FadeInWidget(
          key: ValueKey('collapsed_icon_${animationTrigger.value}'),
          delay: Duration(milliseconds: iconDelay),
          duration: Duration(milliseconds: baseFadeMs),
          isDataChange: isDataChange,
          child: _buildStatusIcon(item.rankChangeType.value),
        ),
        SizedBox(width: 4.w),
        _FadeInWidget(
          key: ValueKey('collapsed_rank_${animationTrigger.value}'),
          delay: Duration(milliseconds: rankDelay),
          duration: Duration(milliseconds: baseFadeMs),
          isDataChange: isDataChange,
          child: Text(
            "${item.rank}",
            style: Pretendard.medium.set(size: 15, color: ColorStyles.white),
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: SizedBox(
            width: 189.w,
            child: Wrap(
              clipBehavior: Clip.hardEdge,
              children: List.generate(titleStr.length, (index) {
                final char = titleStr[index];

                return _FadeInWidget(
                  key: ValueKey(
                    'collapsed_char_${animationTrigger.value}_${index}_$char',
                  ),
                  char: char,
                  delay: Duration(
                    milliseconds: titleBaseDelay + (index * charIntervalMs),
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
          key: ValueKey('collapsed_category_${animationTrigger.value}'),
          delay: Duration(milliseconds: categoryDelay),
          duration: Duration(milliseconds: baseFadeMs),
          isDataChange: isDataChange,
          child: Text(
            categoryStr,
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
