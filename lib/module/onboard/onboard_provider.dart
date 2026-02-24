import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/enum/social.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:collection/collection.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<void> onLogin(WidgetRef ref, SocialProvider provider) async {
  final context = ref.context;

  context.loaderOverlay.show();

  late SocialTokenType type;
  late String token;

  switch (provider) {
    case SocialProvider.kakao:
      type = .accessToken;

      try {
        late OAuthToken oAuthToken;

        if (await isKakaoTalkInstalled()) {
          oAuthToken = await UserApi.instance.loginWithKakaoTalk();
        } else {
          oAuthToken = await UserApi.instance.loginWithKakaoAccount();
        }

        token = oAuthToken.accessToken;
      } catch (e) {
        if (!context.mounted) return;
        context.loaderOverlay.hide();
        if (e is PlatformException && e.code == 'CANCELED') {
          return;
        }

        showMPAlertModal(context, title: "카카오 로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.");
        try {
          await UserApi.instance.logout();
          debugPrint('카카오 로그아웃 완료');
        } catch (e) {
          debugPrint('카카오 로그아웃 중 에러: ${e.toString()}');
        }
      }
      break;
    case SocialProvider.apple:
      type = .idToken;

      if (Platform.isIOS) {
        try {
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [],
          );

          final identityToken = credential.identityToken;

          if (identityToken == null) {
            if (!context.mounted) return;
            context.loaderOverlay.hide();
            showMPAlertModal(
              context,
              title: "애플 로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.",
            );

            return;
          }

          token = identityToken;
        } catch (e) {
          if (!context.mounted) return;
          context.loaderOverlay.hide();
          if (e is SignInWithAppleAuthorizationException &&
              e.code == .canceled) {
            return;
          }

          showMPAlertModal(
            context,
            title: "애플 로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.",
          );
        }
      } else {
        context.loaderOverlay.hide();
        showMPAlertModal(context, title: "애플 로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.");
      }

      break;
    case SocialProvider.google:
      type = .idToken;

      try {
        final account = await GoogleSignIn.instance.authenticate();

        final idToken = account.authentication.idToken;

        if (idToken == null) {
          if (!context.mounted) return;
          context.loaderOverlay.hide();
          showMPAlertModal(
            context,
            title: "구글 로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.",
          );

          return;
        }

        token = idToken;
      } catch (e) {
        if (!context.mounted) return;
        context.loaderOverlay.hide();
        if (e is GoogleSignInException && e.code == .canceled) {
          return;
        }

        showMPAlertModal(context, title: "구글 로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.");
      }
      break;
  }

  if (!context.mounted) return;
  context.loaderOverlay.hide();
}

void showTerm(WidgetRef ref) {
  final context = ref.context;

  showMPBottomSheetModal(
    context,
    children: [
      MPBottomSheetHeader(),
      Padding(
        padding: .symmetric(horizontal: 20.w),
        child: HookBuilder(
          builder: (_) {
            final terms = useState([
              (false, true, "서비스 이용 약관", null),
              (false, true, "개인정보 처리방침", null),
              (false, false, "광고성 정보 수신 동의", null),
            ]);

            final onNextEnabled = !terms.value
                .where((item) => item.$2)
                .map((item) => item.$1)
                .contains(false);

            final allChecked = !terms.value
                .map((item) => item.$1)
                .contains(false);

            return Column(
              crossAxisAlignment: .stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    final newChecked = !allChecked;

                    terms.value = [...terms.value]
                        .map((item) => (newChecked, item.$2, item.$3, item.$4))
                        .toList();
                  },
                  child: Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      borderRadius: .circular(8.r),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [ColorStyles.primary50, ColorStyles.primary20],
                      ),
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      margin: allChecked ? .all(1.r) : .zero,
                      padding: allChecked
                          ? .symmetric(horizontal: 19.w)
                          : .symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: .circular(8.r),
                        color: ColorStyles.gray70,
                      ),
                      child: Row(
                        spacing: 6.w,
                        children: [
                          MPCheckMark(checked: allChecked, size: 24),
                          Expanded(
                            child: Text(
                              "모든 약관에 동의합니다",
                              style: Pretendard.medium.set(
                                size: 16,
                                color: ColorStyles.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                MPHeight(16),
                Column(
                  spacing: 6.h,
                  children: terms.value
                      .mapIndexed(
                        (index, item) => TermItem(
                          item: item,
                          onTap: () {
                            final tmp = [...terms.value];
                            tmp[index] = (!item.$1, item.$2, item.$3, item.$4);
                            terms.value = tmp;
                          },
                        ),
                      )
                      .toList(),
                ),
                MPHeight(40),
                Row(
                  spacing: 20.w,
                  children: [
                    Expanded(
                      child: MPButton("취소", style: .gray, onTap: context.pop),
                    ),
                    Expanded(
                      child: MPButton(
                        "동의",
                        enabled: onNextEnabled,
                        onTap: () {
                          context.pop();
                          context.pushRoute(RegisterNicknameRoute());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      MPHeight(20),
    ],
  );
}

class TermItem extends StatelessWidget {
  // 체크 여부, 필수 여부, 텍스트, URL
  final (bool, bool, String, String?) item;
  final void Function() onTap;

  const TermItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      child: Row(
        spacing: 8.w,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                spacing: 6.w,
                children: [
                  MPCheckMark(checked: item.$1, size: 20),
                  Expanded(
                    child: Text(
                      "${item.$3}(${item.$2 ? "필수" : "선택"})",
                      style: Pretendard.medium.set(
                        size: 15,
                        color: ColorStyles.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: MPSvgImage(SvgImage.arrowRight, size: 18),
          ),
        ],
      ),
    );
  }
}
