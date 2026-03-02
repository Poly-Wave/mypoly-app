part of 'index.dart';

Future<T?> showMPConfirmModal<T>(
  BuildContext context, {
  bool barrierDismissible = true,
  required String title,
  String? content,
  Widget? contentWidget,
  String? cancelText,
  MPButtonStyle cancelButtonStyle = .gray,
  String? okText,
  MPButtonStyle okButtonStyle = .primary,
  void Function()? onDismiss,
  void Function()? onCancelTap,
  void Function()? onOkTap,
}) async {
  return await showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (mContext) => MPConfirmModal(
      barrierDismissible: barrierDismissible,
      title: title,
      content: content,
      contentWidget: contentWidget,
      cancelText: cancelText ?? "닫기",
      cancelButtonStyle: cancelButtonStyle,
      okText: okText ?? "확인",
      okButtonStyle: okButtonStyle,
      onDismiss: onDismiss ?? mContext.pop,
      onCancelTap: onCancelTap ?? onDismiss ?? mContext.pop,
      onOkTap: onOkTap ?? onDismiss ?? mContext.pop,
    ),
  );
}

class MPConfirmModal extends StatelessWidget {
  final bool barrierDismissible;
  final String title;
  final String? content;
  final Widget? contentWidget;
  final String cancelText;
  final MPButtonStyle cancelButtonStyle;
  final String okText;
  final MPButtonStyle okButtonStyle;
  final void Function() onDismiss;
  final void Function() onCancelTap;
  final void Function() onOkTap;

  const MPConfirmModal({
    super.key,
    required this.barrierDismissible,
    required this.title,
    this.content,
    this.contentWidget,
    required this.cancelText,
    required this.cancelButtonStyle,
    required this.okText,
    required this.okButtonStyle,
    required this.onDismiss,
    required this.onCancelTap,
    required this.onOkTap,
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
                    Row(
                      spacing: 10.w,
                      children: [
                        Expanded(
                          child: MPButton(
                            cancelText,
                            onTap: onCancelTap,
                            style: cancelButtonStyle,
                          ),
                        ),
                        Expanded(
                          child: MPButton(
                            okText,
                            onTap: onOkTap,
                            style: okButtonStyle,
                          ),
                        ),
                      ],
                    ),
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
