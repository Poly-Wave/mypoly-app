import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'term_detail_provider.g.dart';

@riverpod
TermsResponse term(Ref ref) => throw UnimplementedError();

@riverpod
class TermHtml extends _$TermHtml {
  @override
  String? build() => null;

  Future<void> fetch(BuildContext context) async {
    final termId = ref.read(termProvider).id;

    try {
      state = await ref.read(termsServiceProvider).getTermHtml(termId);
    } catch (e) {
      if (!context.mounted) return;
      showMPAlertModal(
        context,
        title: "잘못된 접근",
        barrierDismissible: false,
        onTap: () {
          context.pop();
          context.pop();
        },
      );
    }
  }
}
