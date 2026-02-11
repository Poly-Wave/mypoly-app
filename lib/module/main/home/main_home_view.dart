import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/style/index.dart';

class MainHomeView extends HookConsumerWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(color: ColorStyles.black);
  }
}
