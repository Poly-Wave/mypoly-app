import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class RegisterMoreView extends HookConsumerWidget {
  const RegisterMoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMale = useState(true);

    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: MPBackAppbar(context, text: "가까워지는 과정"),
        body: Column(
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: MPSingleScroll(
                child: Padding(
                  padding: .symmetric(vertical: 20.h, horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      Text(
                        "회원가입",
                        style: Pretendard.semiBold.set(
                          size: 28,
                          height: 1.3,
                          letterSpacing: -0.54,
                          color: ColorStyles.white,
                        ),
                      ),
                      MPHeight(6),
                      Text(
                        "서비스 이용을 위한 정보를 작성해 주세요.",
                        style: Pretendard.medium.set(
                          size: 18,
                          height: 1.4,
                          color: ColorStyles.gray30,
                        ),
                      ),
                      MPHeight(40),
                      MPInputLabel("성별", required: true),
                      MPHeight(10),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => isMale.value = true,
                              child: Row(
                                spacing: 6.w,
                                children: [
                                  MPRadio(size: 18, checked: isMale.value),
                                  Text(
                                    "남자",
                                    style: Pretendard.medium.set(
                                      size: 15,
                                      height: 1.45,
                                      color: isMale.value
                                          ? ColorStyles.primary50
                                          : ColorStyles.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => isMale.value = false,
                              child: Row(
                                spacing: 6.w,
                                children: [
                                  MPRadio(size: 18, checked: !isMale.value),
                                  Text(
                                    "여자",
                                    style: Pretendard.medium.set(
                                      size: 15,
                                      height: 1.45,
                                      color: !isMale.value
                                          ? ColorStyles.primary50
                                          : ColorStyles.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      MPHeight(32),
                      MPInputLabel("생년월일", required: true),
                      MPInput(
                        hintText: "생년월일 8자리를 입력해 주세요.",
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: .number,
                      ),
                      MPHeight(32),
                      MPInputLabel("거주지역", required: true),
                    ],
                  ),
                ),
              ),
            ),
            MPBottomButton("다음"),
          ],
        ),
      ),
    );
  }
}
