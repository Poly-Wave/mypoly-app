part of 'index.dart';

Future<T?> showMPBottomSheetModal<T>(
  BuildContext context, {
  bool barrierDismissible = true,
  bool enableDrag = false,
  required List<Widget> children,
}) async {
  return await showModalBottomSheet<T>(
    context: context,
    enableDrag: !barrierDismissible ? barrierDismissible : enableDrag,
    isScrollControlled: true,
    isDismissible: barrierDismissible,
    backgroundColor: ColorStyles.dim,
    builder: (_) => PopScope(
      canPop: barrierDismissible,
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyles.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: MPSafeColumn(
          bottom: true,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    ),
  );
}

class MPBottomSheetHeader extends StatelessWidget {
  const MPBottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return MPHeight(36);
  }
}

class MPBottomSheetCloseHeader extends StatelessWidget {
  final void Function()? onTap;

  const MPBottomSheetCloseHeader({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      padding: .symmetric(horizontal: 20.w),
      alignment: .centerRight,
      child: GestureDetector(
        onTap: onTap ?? context.pop,
        child: Text(
          "닫기",
          style: Pretendard.medium.set(size: 14, color: ColorStyles.gray30),
        ),
      ),
    );
  }
}
