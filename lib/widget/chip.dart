part of 'index.dart';

class MPChip extends StatelessWidget {
  final String text;
  final bool isActive;
  final List<Widget>? activeRights;
  final List<Widget>? inactiveRights;
  final void Function() onTap;

  const MPChip({
    super.key,
    required this.text,
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
        height: 32.h,
        padding: .symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: .circular(999.r),
          border: .all(
            width: 1.r,
            color: isActive ? ColorStyles.primary60 : ColorStyles.gray60,
          ),
        ),
        child: Stack(
          alignment: .center,
          children: [
            AnimatedOpacity(
              opacity: isActive ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Row(
                children: [
                  Text(
                    text,
                    style: Pretendard.semiBold.set(
                      size: 14,
                      color: ColorStyles.gray20,
                    ),
                  ),
                  ...(inactiveRights ?? []),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Row(
                children: [
                  Text(
                    text,
                    style: Pretendard.semiBold.set(
                      size: 14,
                      color: ColorStyles.primary60,
                    ),
                  ),
                  ...(activeRights ?? []),
                ],
              ),
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
