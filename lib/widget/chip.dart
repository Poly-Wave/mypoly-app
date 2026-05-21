part of 'index.dart';

class MPChip extends StatelessWidget {
  final String? text;
  final Widget? widget;
  final double height;
  final EdgeInsetsGeometry? padding;
  final double textSize;
  final bool isActive;
  final List<Widget>? activeRights;
  final List<Widget>? inactiveRights;
  final void Function() onTap;

  const MPChip({
    super.key,
    this.text,
    this.widget,
    this.height = 32,
    this.padding,
    this.textSize = 14,
    required this.isActive,
    this.activeRights,
    this.inactiveRights,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        height: height.h,
        padding: padding ?? .symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: .circular(999.r),
          border: .all(
            width: 1.r,
            color: isActive ? ColorStyles.primary60 : ColorStyles.gray60,
          ),
        ),
        child: Row(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          children: [
            Flexible(
              fit: .loose,
              child:
                  widget ??
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    style: Pretendard.semiBold.set(
                      size: textSize,
                      color: isActive
                          ? ColorStyles.primary60
                          : ColorStyles.gray20,
                    ),
                    child: Text(text ?? ""),
                  ),
            ),
            Stack(
              children: [
                AnimatedOpacity(
                  opacity: isActive ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Row(
                    mainAxisSize: .min,
                    children: inactiveRights ?? [],
                  ),
                ),
                AnimatedOpacity(
                  opacity: isActive ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Row(mainAxisSize: .min, children: activeRights ?? []),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MPFilterChip extends MPChip {
  MPFilterChip({
    super.key,
    required super.text,
    required super.isActive,
    required super.onTap,
  }) : super(
         activeRights: [
           MPWidth(4),
           MPSvgImage(
             SvgImage.arrowDownFilter,
             size: 16,
             color: ColorStyles.primary60,
           ),
         ],
         inactiveRights: [
           MPWidth(4),
           MPSvgImage(
             SvgImage.arrowDownFilter,
             size: 16,
             color: ColorStyles.gray20,
           ),
         ],
       );
}
