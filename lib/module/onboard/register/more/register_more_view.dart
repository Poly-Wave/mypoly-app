import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/module/onboard/register/more/register_more_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/util/valid.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class RegisterMoreView extends HookConsumerWidget {
  const RegisterMoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FlutterNativeSplash.remove();
      });

      return null;
    }, []);

    final gender = ref.watch(onboardGenderProvider);
    final birth = ref.watch(birthProvider);
    final residence = ref.watch(residenceProvider);

    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: MPAppbar(context, text: "가까워지는 과정", isBackEnabled: false),
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
                        "추가 정보 입력",
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
                              onTap: () => ref
                                  .read(onboardGenderProvider.notifier)
                                  .update(.man),
                              child: Row(
                                spacing: 6.w,
                                children: [
                                  MPRadio(size: 18, checked: gender == .man),
                                  Text(
                                    "남자",
                                    style: Pretendard.medium.set(
                                      size: 15,
                                      height: 1.45,
                                      color: gender == .man
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
                              onTap: () => ref
                                  .read(onboardGenderProvider.notifier)
                                  .update(.woman),
                              child: Row(
                                spacing: 6.w,
                                children: [
                                  MPRadio(size: 18, checked: gender == .woman),
                                  Text(
                                    "여자",
                                    style: Pretendard.medium.set(
                                      size: 15,
                                      height: 1.45,
                                      color: gender == .woman
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
                      Stack(
                        children: [
                          MPInput(
                            controller: ref
                                .read(birthProvider.notifier)
                                .controller,
                            focusNode: ref
                                .read(birthProvider.notifier)
                                .focusNode,
                            onChanged: ref
                                .read(birthProvider.notifier)
                                .onChanged,
                            hintText: "생년월일 8자리를 입력해 주세요.",
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: .number,
                            innerRight: Row(
                              mainAxisSize: .min,
                              mainAxisAlignment: .end,
                              children: [
                                if (birth.isNotEmpty) ...[
                                  GestureDetector(
                                    onTap: ref
                                        .read(birthProvider.notifier)
                                        .onReset,
                                    child: MPSvgImage(
                                      SvgImage.icReset,
                                      size: 24,
                                    ),
                                  ),
                                ],
                                MPWidth(16),
                              ],
                            ),
                            innerRightConstraints: .tightForFinite(
                              width: (birth.isNotEmpty ? 24.r : 0) + 16.w,
                            ),
                            message:
                                (birth.length == 10 &&
                                    !Valid.isBirthDate(birth))
                                ? "올바른 생년월일을 입력해 주세요."
                                : null,
                            useMesssage: true,
                          ),
                        ],
                      ),
                      MPHeight(32),
                      MPInputLabel("거주지역", required: true),
                      MPFakeInput(
                        hintText: "지역(읍/면/동)을 입력해 주세요.",
                        value: residence != null
                            ? "${residence.sido} ${residence.sigungu} ${residence.emdName}"
                            : null,
                        onTap: () => ref
                            .read(residenceProvider.notifier)
                            .onShowBottomSheet(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MPBottomButton(
              "다음",
              enabled: ref.watch(onMoreEnabledProvider),
              onTap: () => onMore(ref),
            ),
          ],
        ),
      ),
    );
  }
}
