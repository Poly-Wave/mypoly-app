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
import 'package:mypoly/generate/users/model/terms_agreement_request.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/app_user_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/event.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:collection/collection.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void showLoginError(BuildContext context, SocialProvider provider) =>
    showMPAlertModal(
      context,
      title: "${provider.text} 로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.",
    );

Future<void> onLogin(WidgetRef ref, SocialProvider provider) async {
  final context = ref.context;

  context.loaderOverlay.show();

  await Event.send(
    name: "login_btn_click",
    parameters: {"platform": provider.name},
  );

  late SocialTokenType tokenType;
  late String token;

  switch (provider) {
    case SocialProvider.kakao:
      tokenType = .accessToken;

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

        showLoginError(context, provider);
        try {
          await UserApi.instance.logout();
          debugPrint('카카오 로그아웃 완료');
        } catch (e) {
          debugPrint('카카오 로그아웃 중 에러: ${e.toString()}');
        }
      }
      break;
    case SocialProvider.apple:
      tokenType = .idToken;

      if (Platform.isIOS) {
        try {
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [],
          );

          final identityToken = credential.identityToken;

          if (identityToken == null) {
            if (!context.mounted) return;
            context.loaderOverlay.hide();
            showLoginError(context, provider);

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

          showLoginError(context, provider);
        }
      } else {
        if (!context.mounted) return;
        context.loaderOverlay.hide();
        showLoginError(context, provider);
      }

      break;
    case SocialProvider.google:
      tokenType = .idToken;

      try {
        final account = await GoogleSignIn.instance.authenticate();

        final idToken = account.authentication.idToken;

        if (idToken == null) {
          if (!context.mounted) return;
          context.loaderOverlay.hide();
          showLoginError(context, provider);

          return;
        }

        token = idToken;
      } catch (e) {
        if (!context.mounted) return;
        context.loaderOverlay.hide();
        if (e is GoogleSignInException && e.code == .canceled) {
          return;
        }

        showLoginError(context, provider);
      }
      break;
  }

  try {
    final response = await ref
        .read(appUserProvider.notifier)
        .signIn(provider: provider, tokenType: tokenType, token: token);

    await Event.send(name: "login_completed");

    if (!context.mounted) return;
    context.loaderOverlay.hide();

    switch (response.onboardingStatus) {
      case .signup:
        context.replaceRoute(RegisterOnboardRoute());
        break;
      case .onboarding:
        context.replaceRoute(RegisterTopicRoute());
        break;
      case .category:
        context.replaceRoute(RegisterMoreRoute());
        break;
      default:
        context.replaceRoute(MainRoute());
        break;
    }
  } on String catch (e) {
    if (!context.mounted) return;
    context.loaderOverlay.hide();

    switch (e) {
      case "USER_NOT_FOUND":
        showTerm(ref, provider: provider, tokenType: tokenType, token: token);
        break;
      default:
        showLoginError(context, provider);
        break;
    }
  } catch (e) {
    if (!context.mounted) return;
    context.loaderOverlay.hide();
    showLoginError(context, provider);
  }
}

Future<void> showTerm(
  WidgetRef ref, {
  required SocialProvider provider,
  required SocialTokenType tokenType,
  required String token,
}) async {
  final context = ref.context;

  final appTerms = ref.read(appTermsProvider);

  showMPBottomSheetModal(
    context,
    children: [
      MPBottomSheetHeader(),
      Padding(
        padding: .symmetric(horizontal: 20.w),
        child: HookBuilder(
          builder: (_) {
            useEffect(() {
              Event.send(name: "terms_pv");

              return null;
            }, []);

            final terms = useState(
              appTerms.map((term) => (false, term)).toList(),
            );

            final onNextEnabled = !terms.value
                .where((item) => item.$2.required_)
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

                    terms.value = [
                      ...terms.value,
                    ].map((item) => (newChecked, item.$2)).toList();
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
                            tmp[index] = (!item.$1, item.$2);
                            terms.value = tmp;
                          },
                          onDetailTap: () =>
                              context.pushRoute(TermDetailRoute(data: item.$2)),
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
                          Event.send(
                            name: "terms_agree_btn_click",
                            parameters: {
                              "marketing_agreed":
                                  terms.value.firstWhereOrNull(
                                    (term) => term.$1 && term.$2.isMarketing,
                                  ) !=
                                  null,
                            },
                          );

                          context.pop();
                          context.pushRoute(
                            RegisterNicknameRoute(
                              provider: provider,
                              tokenType: tokenType,
                              token: token,
                              terms: terms.value
                                  .map(
                                    (data) => TermsAgreementRequest(
                                      termId: data.$2.id,
                                      agreed: data.$1,
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
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
  ).then((_) {
    Event.send(name: "terms_close_btn_click");
  });
}

class TermItem extends StatelessWidget {
  final (bool, TermsResponse) item;
  final void Function() onTap;
  final void Function() onDetailTap;

  const TermItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDetailTap,
  });

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
                      "${item.$2.title}(${(item.$2.required_) ? "필수" : "선택"})",
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
            onTap: onDetailTap,
            child: MPSvgImage(SvgImage.arrowRight, size: 18),
          ),
        ],
      ),
    );
  }
}
