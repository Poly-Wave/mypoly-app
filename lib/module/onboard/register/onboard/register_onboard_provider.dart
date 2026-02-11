import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_onboard_provider.g.dart';

@riverpod
PageController registerOnboardPageContaoller(Ref ref) => PageController();

@riverpod
class RegisterOnboardStep extends _$RegisterOnboardStep {
  @override
  int build() => 0;

  void update(int value) => state = value;
}
