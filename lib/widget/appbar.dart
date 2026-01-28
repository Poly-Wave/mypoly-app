part of 'index.dart';

class MPBackAppbar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final Color color;
  final void Function()? onBack;
  final String text;
  final List<Widget>? left;
  final List<Widget>? right;

  const MPBackAppbar(
    this.context, {
    super.key,
    this.color = ColorStyles.black,
    this.onBack,
    this.text = "",
    this.left,
    this.right,
  });

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
              GestureDetector(
                onTap: onBack ?? context.pop,
                child: MPSvgImage(SvgImage.icBack, size: 32),
              ),
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
              Container(width: 32.r),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(double.infinity, MediaQuery.of(context).padding.top + 59.h);
}
