import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/enum/social.dart';
import 'package:mypoly/generate/users/model/terms_agreement_request.dart';
import 'package:mypoly/module/onboard/register/nickname/register_nickname_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';

@RoutePage()
class RegisterNicknameView extends HookConsumerWidget {
  final SocialProvider provider;
  final SocialTokenType tokenType;
  final String token;
  final List<TermsAgreementRequest> terms;

  const RegisterNicknameView({
    super.key,
    required this.provider,
    required this.tokenType,
    required this.token,
    required this.terms,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(nicknameProvider);
    final nicknameInputMessage = ref.watch(nicknameInputMessageProvider);

    final isPop = useState(false);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (isPop.value) {
          return;
        }

        showMPConfirmModal(
          context,
          title: "지금 나가면 처음부터 다시해야 해요.\n그만하고 나가시겠어요?",
          okText: "그만하기",
          onOkTap: () {
            isPop.value = true;
            context.pop();
            context.pop();
          },
        );
      },
      child: GestureDetector(
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
                          hintText: "한글, 숫자 포함 4~12자 입력",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[가-힣ㄱ-ㅎㅏ-ㅣ0-9\s·]'),
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
                              GestureDetector(
                                onTap: () => ref
                                    .read(nicknameProvider.notifier)
                                    .onRandom(context),
                                child: MPSvgImage(SvgImage.icChange, size: 24),
                              ),
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
                          useMesssage: false,
                        ),
                        MPHeight(10),
                        Row(
                          spacing: 10.w,
                          children: [
                            RegisterNicknameButton(
                              "중복확인",
                              enabled: ref.watch(onNextCheckEnabledProvider),
                              onTap: () => ref
                                  .read(nicknameCheckProvider.notifier)
                                  .onConfirm(context),
                            ),
                            Expanded(
                              child: Text(
                                nicknameInputMessage?.$1 ?? "",
                                style: Pretendard.medium.set(
                                  size: 14,
                                  color: (nicknameInputMessage?.$2 ?? .default_)
                                      .color,
                                ),
                              ),
                            ),
                          ],
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
                onTap: () => onNext(
                  ref,
                  provider: provider,
                  tokenType: tokenType,
                  token: token,
                  terms: terms,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterNicknameButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final void Function() onTap;

  const RegisterNicknameButton(
    this.text, {
    super.key,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        height: 32.h,
        padding: .symmetric(horizontal: 10.w),
        alignment: .center,
        decoration: BoxDecoration(
          borderRadius: .circular(8.r),
          border: .all(width: 1.r, color: ColorStyles.gray60),
          color: enabled ? ColorStyles.gray70 : Color(0xFF222324),
        ),
        child: Text(
          text,
          style: Pretendard.semiBold.set(
            size: 14,
            color: enabled ? ColorStyles.white : ColorStyles.gray60,
          ),
        ),
      ),
    );
  }
}
