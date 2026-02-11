import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_provider.g.dart';

@riverpod
class MainPage extends _$MainPage {
  final pageController = PageController(initialPage: 1);

  @override
  int build() => 1;

  void update(int value) => state = value;
}
