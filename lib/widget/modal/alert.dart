part of 'index.dart';

Future<T?> showMPAlertModal<T>(
  BuildContext context, {
  bool barrierDismissible = true,
  required String title,
  String? content,
  Widget? contentWidget,
  Widget? subButton,
  String? buttonText,
  MPButtonStyle buttonStyle = .primary,
  void Function()? onDismiss,
  void Function()? onTap,
}) async {
  return await showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (mContext) => MPAlertModal(
      barrierDismissible: barrierDismissible,
      title: title,
      content: content,
      contentWidget: contentWidget,
      subButton: subButton,
      buttonText: buttonText ?? "확인",
      buttonStyle: buttonStyle,
      onDismiss: onDismiss ?? mContext.pop,
      onTap: onTap ?? onDismiss ?? mContext.pop,
    ),
  );
}

class MPAlertModal extends StatelessWidget {
  final bool barrierDismissible;
  final String title;
  final String? content;
  final Widget? contentWidget;
  final Widget? subButton;
  final String buttonText;
  final MPButtonStyle buttonStyle;
  final void Function() onDismiss;
  final void Function() onTap;

  const MPAlertModal({
    super.key,
    required this.barrierDismissible,
    required this.title,
    this.content,
    this.contentWidget,
    this.subButton,
    required this.buttonText,
    required this.buttonStyle,
    required this.onDismiss,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: barrierDismissible,
      child: GestureDetector(
        onTap: barrierDismissible ? onDismiss : null,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Padding(
              padding: .symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: .circular(16.r),
                  color: ColorStyles.gray70,
                ),
                padding: .symmetric(vertical: 20.h, horizontal: 16.w),
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .stretch,
                  children: [
                    Padding(
                      padding: .symmetric(horizontal: 4.w),
                      child: Text(
                        title,
                        textAlign: .center,
                        style: Pretendard.semiBold.set(
                          size: 18,
                          height: 1.4,
                          color: ColorStyles.white,
                        ),
                      ),
                    ),
                    if (content != null) ...[
                      MPHeight(6),
                      Padding(
                        padding: .symmetric(horizontal: 5.w),
                        child: Text(
                          content ?? "",
                          textAlign: TextAlign.center,
                          style: Pretendard.medium.set(
                            size: 14,
                            height: 1.45,
                            color: ColorStyles.gray30,
                          ),
                        ),
                      ),
                    ],
                    contentWidget ?? SizedBox.shrink(),
                    MPHeight(20),
                    MPButton(buttonText, onTap: onTap, style: buttonStyle),
                    subButton ?? SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
