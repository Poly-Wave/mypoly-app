import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/util/valid.dart';
import 'package:mypoly/widget/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_nickname_provider.g.dart';

@riverpod
class Nickname extends _$Nickname {
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
    if (value.isEmpty) {
      ref.read(nicknameInputMessageProvider.notifier).reset();
    } else {
      if (Valid.nickname.hasMatch(value)) {
        ref.read(nicknameInputMessageProvider.notifier).reset();
      } else {
        ref.read(nicknameInputMessageProvider.notifier).onUpdate((
          "한글로 최대 4~12자 입력해 주세요.",
          .error,
        ));
      }
    }

    state = value;
  }

  void onReset() {
    controller.text = "";
    state = "";
  }
}

@riverpod
class NicknameInputMessage extends _$NicknameInputMessage {
  @override
  (String, MPInputMessageType)? build() => null;

  void onUpdate((String, MPInputMessageType) value) => state = value;

  void reset() => state = null;
}

@riverpod
bool onNextEnabled(Ref ref) =>
    ref.watch(nicknameProvider).isNotEmpty &&
    ref.watch(nicknameInputMessageProvider) == null;

void onNext(WidgetRef ref) {
  final context = ref.context;
  final nickname = ref.read(nicknameProvider);

  context.router.replaceAll([
    MainRoute(),
    RegisterOnboardRoute(nickname: nickname),
  ]);
}
