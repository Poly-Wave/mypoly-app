part of 'index.dart';

enum MPButtonStyle {
  primary,
  gray,
  line,
  text;

  BoxDecoration toDefaultDecoration() {
    switch (this) {
      case MPButtonStyle.primary:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.primary50),
          color: ColorStyles.primary50,
        );
      case MPButtonStyle.gray:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.gray60),
          color: ColorStyles.gray60,
        );
      case MPButtonStyle.line:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.gray60),
          color: ColorStyles.gray70,
        );
      case MPButtonStyle.text:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: Colors.transparent),
          color: Colors.transparent,
        );
    }
  }

  BoxDecoration toDisabledDecoration() {
    switch (this) {
      case MPButtonStyle.primary:
      case MPButtonStyle.gray:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.gray70),
          color: ColorStyles.gray70,
        );
      case MPButtonStyle.line:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.gray60),
          color: Color(0xFF222324),
        );
      case MPButtonStyle.text:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: Colors.transparent),
          color: Colors.transparent,
        );
    }
  }

  TextStyle toDefaultTextStyle() {
    switch (this) {
      case MPButtonStyle.primary:
        return Pretendard.semiBold.set(size: 18, color: ColorStyles.black);
      case MPButtonStyle.gray:
      case MPButtonStyle.line:
        return Pretendard.semiBold.set(size: 18, color: ColorStyles.white);
      case MPButtonStyle.text:
        return Pretendard.semiBold.set(size: 18, color: ColorStyles.gray20);
    }
  }

  TextStyle toDisabledTextStyle() {
    switch (this) {
      case MPButtonStyle.primary:
      case MPButtonStyle.gray:
      case MPButtonStyle.line:
      case MPButtonStyle.text:
        return Pretendard.semiBold.set(size: 18, color: ColorStyles.gray60);
    }
  }

  BoxDecoration toPressedDecoration() {
    switch (this) {
      case MPButtonStyle.primary:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.primary60),
          color: ColorStyles.primary60,
        );
      case MPButtonStyle.gray:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.gray60),
          color: ColorStyles.gray60,
        );
      case MPButtonStyle.line:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.gray50),
          color: ColorStyles.gray70,
        );
      case MPButtonStyle.text:
        return BoxDecoration(
          borderRadius: .circular(12.r),
          border: Border.all(width: 1.r, color: ColorStyles.gray60),
          color: ColorStyles.gray60,
        );
    }
  }

  TextStyle toPressedTextStyle() {
    switch (this) {
      case MPButtonStyle.primary:
        return Pretendard.semiBold.set(size: 18, color: ColorStyles.black);
      case MPButtonStyle.gray:
      case MPButtonStyle.line:
        return Pretendard.semiBold.set(size: 18, color: ColorStyles.gray40);
      case MPButtonStyle.text:
        return Pretendard.semiBold.set(size: 18, color: ColorStyles.gray20);
    }
  }
}

class MPBottomButton extends MPButton {
  const MPBottomButton(
    super.text, {
    super.key,
    super.style,
    super.enabled,
    super.onTap,
    super.onTapForced,
  }) : super(height: 57, borderRadius: .zero, safeBottom: true);
}

class MPButton extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onTapForced;
  final MPButtonStyle style;
  final bool enabled;
  final String text;
  final double height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final BoxDecoration? decoration;
  final BorderRadiusGeometry? borderRadius;
  final List<Widget>? left;
  final List<Widget>? right;
  final bool safeBottom;

  const MPButton(
    this.text, {
    super.key,
    this.style = .primary,
    this.enabled = true,
    this.onTap,
    this.onTapForced,
    this.height = 57,
    this.width,
    this.padding,
    this.textStyle,
    this.decoration,
    this.borderRadius,
    this.left,
    this.right,
    this.safeBottom = false,
  });

  @override
  State<MPButton> createState() => _MPButtonState();
}

class _MPButtonState extends State<MPButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration =
        widget.decoration ??
        (widget.enabled
            ? (_isPressed
                  ? widget.style.toPressedDecoration()
                  : widget.style.toDefaultDecoration())
            : widget.style.toDisabledDecoration());

    if (widget.borderRadius != null) {
      boxDecoration = boxDecoration.copyWith(borderRadius: widget.borderRadius);
    }

    TextStyle textStyle =
        widget.textStyle ??
        (widget.enabled
            ? (_isPressed
                  ? widget.style.toPressedTextStyle()
                  : widget.style.toDefaultTextStyle())
            : widget.style.toDisabledTextStyle());

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        if (widget.onTapForced != null) {
          widget.onTapForced!();
        } else if (widget.enabled && widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        padding: widget.padding,
        decoration: boxDecoration,
        child: MPSafeBox(
          bottom: widget.safeBottom,
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Row(
              mainAxisSize: widget.padding != null ? .min : .max,
              mainAxisAlignment: .center,
              children: [
                ...widget.left ?? [],
                Flexible(
                  fit: .loose,
                  child: Text(
                    widget.text,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: textStyle,
                  ),
                ),
                ...widget.right ?? [],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
