part of 'index.dart';

class MPSortSwitch<T extends MPSortOption> extends StatelessWidget {
  final T value;
  final ValueChanged<T> onChanged;

  const MPSortSwitch({super.key, required this.value, required this.onChanged});

  List<T> get _values {
    final values = value.options.cast<T>();
    assert(values.length == 2, "MPSortSwitch only supports two values.");
    return values;
  }

  @override
  Widget build(BuildContext context) {
    final switchValues = _values;
    final first = switchValues.first;
    final second = switchValues.last;

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
            alignment: value == first ? .centerLeft : .centerRight,
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
                text: first.text,
                isActive: value == first,
                onTap: () => onChanged(first),
              ),
              SizedBox(width: 4.w),
              MPSortItem(
                text: second.text,
                isActive: value == second,
                onTap: () => onChanged(second),
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
