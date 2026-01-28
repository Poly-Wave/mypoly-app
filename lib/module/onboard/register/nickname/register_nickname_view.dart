import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/module/onboard/register/nickname/register_nickname_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class RegisterNicknameView extends HookConsumerWidget {
  const RegisterNicknameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(nicknameProvider);
    final nicknameInputMessage = ref.watch(nicknameInputMessageProvider);

    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: MPBackAppbar(context),
        body: Column(
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: MPSingleScroll(
                child: Padding(
                  padding: .symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      MPHeight(20),
                      Text(
                        "사용하실 별명을\n입력해 주세요",
                        style: Pretendard.semiBold.set(
                          size: 28,
                          height: 1.3,
                          letterSpacing: -0.54,
                          color: ColorStyles.white,
                        ),
                      ),
                      MPHeight(40),
                      MPInput(
                        controller: ref
                            .read(nicknameProvider.notifier)
                            .controller,
                        focusNode: ref
                            .read(nicknameProvider.notifier)
                            .focusNode,
                        onChanged: ref
                            .read(nicknameProvider.notifier)
                            .onChanged,
                        hintText: "한글로 최대 4~12자 입력",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[가-힣ㄱ-ㅎㅏ-ㅣ]'),
                          ),
                        ],
                        innerRight: Row(
                          mainAxisSize: .min,
                          mainAxisAlignment: .end,
                          children: [
                            if (nickname.isNotEmpty) ...[
                              GestureDetector(
                                onTap: ref
                                    .read(nicknameProvider.notifier)
                                    .onReset,
                                child: MPSvgImage(SvgImage.icReset, size: 24),
                              ),
                              MPWidth(8),
                            ],
                            MPSvgImage(SvgImage.icChange, size: 24),
                            MPWidth(16),
                          ],
                        ),
                        innerRightConstraints: .tightForFinite(
                          width:
                              (nickname.isNotEmpty ? 8.w + 24.r : 0) +
                              8.w +
                              24.r +
                              8.w,
                        ),
                        maxLength: 12,
                        message: nicknameInputMessage?.$1,
                        messageType: nicknameInputMessage?.$2 ?? .default_,
                        useMesssage: true,
                      ),
                      MPHeight(40),
                    ],
                  ),
                ),
              ),
            ),
            MPBottomButton(
              "다음",
              enabled: ref.watch(onNextEnabledProvider),
              onTap: () => onNext(ref),
            ),
          ],
        ),
      ),
    );
  }
}
