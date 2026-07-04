part of 'index.dart';

class MPAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final Color color;
  final bool isBackEnabled;
  final void Function()? onBack;
  final String text;
  final Widget? left;
  final Widget? right;

  const MPAppBar(
    this.context, {
    super.key,
    this.color = ColorStyles.black,
    this.isBackEnabled = true,
    this.onBack,
    this.text = "",
    this.left,
    this.right,
  });

  @override
  Size get preferredSize =>
      Size(double.infinity, MediaQuery.of(context).padding.top + 59.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: MPSafeBox(
        top: true,
        child: Container(
          height: 59.h,
          padding: .symmetric(horizontal: 20.w),
          child: Row(
            spacing: 24.w,
            children: [
              left ??
                  (isBackEnabled
                      ? GestureDetector(
                          onTap: onBack ?? context.maybePop,
                          child: MPSvgImage(SvgImage.icBack, size: 32),
                        )
                      : MPWidth(32)),
              Expanded(
                child: Text(
                  text,
                  textAlign: .center,
                  style: Pretendard.medium.set(
                    size: 18,
                    color: ColorStyles.white,
                  ),
                ),
              ),
              right ?? MPWidth(32),
            ],
          ),
        ),
      ),
    );
  }
}
