import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/module/main/home/my_info/edit/my_info_edit_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/util/valid.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class MyInfoEditView extends HookConsumerWidget {
  const MyInfoEditView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(infoEditGenderProvider);
    final birth = ref.watch(birthProvider);
    final residence = ref.watch(residenceProvider);
    final nickname = ref.watch(nicknameProvider);

    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: MPAppBar(context, text: "내정보 수정"),
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
                      MPHeight(20),
                      Center(
                        child: Stack(
                          children: [MPImage(WebpImage.emptyProfile, size: 64)],
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
                                  .read(infoEditGenderProvider.notifier)
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
                                  .read(infoEditGenderProvider.notifier)
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
                      MPInputLabel("별명", required: true),
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
                            RegExp(r'[가-힣ㄱ-ㅎㅏ-ㅣ0-9\sㆍ]'),
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
                              MPWidth(16),
                            ],
                          ],
                        ),
                        innerRightConstraints: .tightForFinite(
                          width: (nickname.isNotEmpty ? 24.r : 0) + 16.w,
                        ),
                        maxLength: 12,
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
              enabled: ref.watch(onSaveEnabledProvider),
              onTap: () => onSave(ref),
            ),
          ],
        ),
      ),
    );
  }
}
