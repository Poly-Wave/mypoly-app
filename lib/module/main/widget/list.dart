import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class EmptyWidget extends StatelessWidget {
  final String? image;
  final String message;
  final String subMessage;
  final String buttonText;
  final void Function() onTap;

  const EmptyWidget({
    super.key,
    this.image,
    required this.message,
    required this.subMessage,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: .stretch,
      children: [
        if (image != null) ...[
          Center(child: MPImage(image ?? "", size: 64)),
          MPHeight(10),
        ],
        Text(
          message,
          textAlign: .center,
          style: Pretendard.semiBold.set(
            size: 18,
            height: 1.4,
            color: ColorStyles.white,
          ),
        ),
        MPHeight(8),
        Text(
          subMessage,
          textAlign: .center,
          style: Pretendard.medium.set(
            size: 15,
            height: 1.45,
            color: ColorStyles.gray30,
          ),
        ),
        MPHeight(20),
        Center(
          child: MPButton(
            buttonText,
            style: .line,
            height: 38,
            padding: .symmetric(horizontal: 14.w),
            borderRadius: .circular(8.r),
            textStyle: Pretendard.semiBold.set(
              size: 15,
              color: ColorStyles.white,
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
