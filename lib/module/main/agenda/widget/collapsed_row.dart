import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/widget/index.dart';

class CollapsedRow extends HookWidget {
  final dynamic item;
  final VoidCallback onExpandPressed;

  const CollapsedRow({
    super.key,
    required this.item,
    required this.onExpandPressed,
  });

  @override
  Widget build(BuildContext context) {
    final animationTrigger = useState(0);

    useEffect(() {
      animationTrigger.value = item.rank;
      return null;
    }, [item.rank]);

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
          child: SizedBox(
            width: 189.w,
            child: Wrap(
              clipBehavior: Clip.hardEdge,
              children: List.generate(item.title.length, (index) {
                final char = item.title[index];

                return _FadeInChar(
                  key: ValueKey('${animationTrigger.value}_${index}_$char'),
                  char: char,
                  delay: Duration(milliseconds: index * 50),
                );
              }),
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

class _FadeInChar extends HookWidget {
  final String char;
  final Duration delay;

  const _FadeInChar({super.key, required this.char, required this.delay});

  @override
  Widget build(BuildContext context) {
    final opacity = useState(0.0);

    useEffect(() {
      final timer = Future.delayed(delay, () {
        opacity.value = 1.0;
      });
      return null;
    }, []);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      curve: Curves.linear,
      opacity: opacity.value,
      child: Text(
        char,
        style: Pretendard.medium.set(size: 15, color: Colors.white),
      ),
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
