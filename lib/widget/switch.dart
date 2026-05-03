part of 'index.dart';

enum MPSort { popular, latest }

class MPSortSwitch extends StatelessWidget {
  final MPSort value;
  final ValueChanged<MPSort> onChanged;

  const MPSortSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 26.h,
      padding: .symmetric(vertical: 3.r, horizontal: 4.r),
      decoration: BoxDecoration(
        borderRadius: .circular(6.r),
        color: ColorStyles.gray80,
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            alignment: value == MPSort.popular ? .centerLeft : .centerRight,
            child: Container(
              width: 44.w,
              height: 20.h,
              decoration: BoxDecoration(
                borderRadius: .circular(4.r),
                color: ColorStyles.primary20,
              ),
            ),
          ),
          Row(
            children: [
              MPSortItem(
                text: "인기순",
                isActive: value == .popular,
                onTap: () => onChanged(.popular),
              ),
              SizedBox(width: 4.w),
              MPSortItem(
                text: "최신순",
                isActive: value == .latest,
                onTap: () => onChanged(.latest),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MPSortItem extends StatelessWidget {
  final String text;
  final bool isActive;
  final void Function() onTap;

  const MPSortItem({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: SizedBox(
        width: 44.w,
        height: 20.h,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            style: Pretendard.semiBold.set(
              size: 12,
              color: isActive ? ColorStyles.gray70 : ColorStyles.gray40,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
