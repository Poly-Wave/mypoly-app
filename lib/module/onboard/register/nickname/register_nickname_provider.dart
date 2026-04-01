import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/social.dart';
import 'package:mypoly/generate/users/model/terms_agreement_request.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/util/event.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/util/valid.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_nickname_provider.g.dart';

@riverpod
class Nickname extends _$Nickname {
  bool isRecommended = false;

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  String build() {
    ref.onDispose(() {
      controller.dispose();
      focusNode.dispose();
    });

    return "";
  }

  void onChanged(String value) {
    isRecommended = false;
    if (state != value) {
      ref.read(nicknameCheckProvider.notifier).onReset();
    }
    state = value;
  }

  void onReset() {
    isRecommended = false;
    ref.read(nicknameCheckProvider.notifier).onReset();
    controller.text = "";
    state = "";
  }

  Future<void> onRandom(BuildContext context) async {
    context.unFocus();

    context.loaderOverlay.show();

    try {
      final nickname = await ref.read(userServiceProvider).randomeNickname();

      isRecommended = true;

      if (!context.mounted) return;
      context.loaderOverlay.hide();
      ref.read(nicknameCheckProvider.notifier).update(true);
      controller.text = nickname;
      state = nickname;
    } catch (e) {
      context.loaderOverlay.hide();
      showMPAlertModal(context, title: "닉네임 자동 생성에 실패하였습니다.\n잠시 후 다시 시도해 주세요.");
    }
  }
}

@riverpod
class NicknameCheck extends _$NicknameCheck {
  @override
  bool build() => false;

  Future<void> onConfirm(BuildContext context) async {
    context.unFocus();

    final nickname = ref.read(nicknameProvider);

    if (!Valid.nickname.hasMatch(nickname)) {
      ref.read(nicknameInputMessageProvider.notifier).onUpdate((
        "한글, 숫자로 최대 4~12자 입력해 주세요.",
        .error,
      ));
      return;
    }

    try {
      context.loaderOverlay.show();

      final status = await ref
          .read(userServiceProvider)
          .checkNickname(nickname);

      if (!context.mounted) return;
      context.loaderOverlay.hide();

      state = status == .available;

      switch (status) {
        case .available:
          ref.read(nicknameInputMessageProvider.notifier).onUpdate((
            "사용할 수 있어요.",
            .default_,
          ));
          break;
        case .duplicated:
          ref.read(nicknameInputMessageProvider.notifier).onUpdate((
            "이미 사용 중인 별명이에요.",
            .error,
          ));
          break;
        case .forbidden:
          ref.read(nicknameInputMessageProvider.notifier).onUpdate((
            "사용할 수 없는 별명이에요.",
            .error,
          ));
          break;
      }
    } catch (e) {
      if (!context.mounted) return;
      context.loaderOverlay.hide();

      state = false;
      ref.read(nicknameInputMessageProvider.notifier).onUpdate((
        "한글, 숫자로 최대 4~12자 입력해 주세요.",
        .error,
      ));
    }
  }

  void update(bool value) => state = value;

  void onReset() {
    state = false;
    ref.read(nicknameInputMessageProvider.notifier).reset();
  }
}

@riverpod
bool onNextCheckEnabled(Ref ref) =>
    Valid.nickname.hasMatch(ref.watch(nicknameProvider));

@riverpod
class NicknameInputMessage extends _$NicknameInputMessage {
  @override
  (String, MPInputMessageType)? build() => null;

  void onUpdate((String, MPInputMessageType) value) => state = value;

  void reset() => state = null;
}

@riverpod
bool onNextEnabled(Ref ref) => ref.watch(nicknameCheckProvider);

Future<void> onNext(
  WidgetRef ref, {
  required SocialProvider provider,
  required SocialTokenType tokenType,
  required String token,
  required List<TermsAgreementRequest> terms,
}) async {
  final context = ref.context;

  context.unFocus();

  final nickname = ref.read(nicknameProvider);
  final isRecommended = ref.read(nicknameProvider.notifier).isRecommended;

  context.loaderOverlay.show();

  try {
    await ref
        .read(appUserProvider.notifier)
        .signUp(
          provider: provider,
          tokenType: tokenType,
          token: token,
          nickname: nickname,
          terms: terms,
        );

    await Event.send(name: "signup_completed");
    await Event.send(
      name: "nickname_set_next_btn_click",
      parameters: {"input_type": isRecommended ? "recommended" : "manual"},
    );

    if (!context.mounted) return;
    context.loaderOverlay.hide();
    context.replaceRoute(RegisterOnboardRoute());
  } catch (e) {
    if (!context.mounted) return;
    context.loaderOverlay.hide();
    showMPAlertModal(context, title: "회원가입에 실패하였습니다.\n잠시 후 다시 시도해 주세요.");
  }
}
