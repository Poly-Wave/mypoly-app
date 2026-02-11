part of 'index.dart';

enum MPInputMessageType {
  default_(color: ColorStyles.gray50),
  error(color: ColorStyles.danger50);

  final Color color;

  const MPInputMessageType({required this.color});
}

class MPInputLabel extends StatelessWidget {
  final String text;
  final bool required;

  const MPInputLabel(this.text, {super.key, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(bottom: 4.h),
      child: Row(
        spacing: 2.w,
        children: [
          Text(
            text,
            style: Pretendard.medium.set(
              size: 15,
              height: 1.45,
              color: ColorStyles.white,
            ),
          ),
          if (required)
            Text(
              "*",
              style: Pretendard.medium.set(
                size: 15,
                height: 1.45,
                color: ColorStyles.danger50,
              ),
            ),
        ],
      ),
    );
  }
}

class MPInput extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool enabled;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? hintText;
  final String? message;
  final MPInputMessageType messageType;
  final bool useMesssage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Widget? innerRight;
  final BoxConstraints? innerRightConstraints;
  final Widget? right;
  final EdgeInsets? scrollPadding;
  final TextInputAction? textInputAction;

  const MPInput({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.message,
    this.useMesssage = false,
    this.messageType = .error,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.innerRight,
    this.innerRightConstraints,
    this.right,
    this.scrollPadding,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    final isNotEmptyMessage = message?.isNotEmpty ?? false;

    final border = OutlineInputBorder(
      borderSide: .none,
      borderRadius: BorderRadius.circular(8.r),
    );

    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                textInputAction: textInputAction,
                maxLines: 1,
                maxLength: maxLength,
                controller: controller,
                focusNode: focusNode,
                enabled: enabled,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                obscureText: obscureText,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                scrollPadding: scrollPadding ?? .all(20.r),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Color(0xFF222324),
                  border: border,
                  enabledBorder: border,
                  disabledBorder: border,
                  focusedBorder: border,
                  contentPadding: .symmetric(vertical: 18.h, horizontal: 16.w),
                  hintText: hintText,
                  counterText: "",
                  hintStyle: Pretendard.medium.set(
                    size: 16,
                    color: ColorStyles.gray60,
                  ),
                  suffixIcon: innerRight,
                  suffixIconConstraints: innerRightConstraints,
                ),
                cursorColor: ColorStyles.primary60,
                style: Pretendard.medium.set(
                  size: 16,
                  color: ColorStyles.white,
                ),
              ),
            ),
            right ?? const SizedBox.shrink(),
          ],
        ),
        if (useMesssage)
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Column(
              crossAxisAlignment: .stretch,
              children: [
                MPHeight(4),
                Text(
                  message ?? '',
                  style: Pretendard.medium.set(
                    size: 14,
                    height: 1.45,
                    color: messageType.color,
                  ),
                ),
              ],
            ),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState: isNotEmptyMessage ? .showSecond : .showFirst,
            duration: const Duration(milliseconds: 300),
          ),
      ],
    );
  }
}
