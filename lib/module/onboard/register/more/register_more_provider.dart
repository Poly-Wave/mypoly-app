import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/util/valid.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_more_provider.g.dart';

@riverpod
class IsMale extends _$IsMale {
  @override
  bool build() => true;

  void update(bool value) => state = value;
}

@riverpod
class Birth extends _$Birth {
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
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 8) {
      final trimmed = digits.substring(0, 8);
      controller.text = _formatBirthDate(trimmed);
      state = _formatBirthDate(trimmed);
      return;
    }

    final formatted = _formatBirthDate(digits);
    controller.text = formatted;
    state = formatted;
  }

  String _formatBirthDate(String digits) {
    if (digits.isEmpty) return '';
    if (digits.length <= 4) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 4)}.${digits.substring(4)}';
    }
    return '${digits.substring(0, 4)}.${digits.substring(4, 6)}.${digits.substring(6)}';
  }

  void onReset() {
    controller.text = "";
    state = "";
  }
}

@riverpod
class Keyword extends _$Keyword {
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

  void onChanged(String value) => state = value;

  void onReset() {
    controller.text = "";
    state = "";
  }
}

@riverpod
class Residence extends _$Residence {
  @override
  String? build() => null;

  void update(String value) => state = value;

  Future<void> onShowBottomSheet(BuildContext context) async {
    await showMPBottomSheetModal(
      context,
      children: [
        MPBottomSheetCloseHeader(),
        SizedBox(
          height: 620.h,
          child: Consumer(
            builder: (_, ref, _) {
              final keyword = ref.watch(keywordProvider);

              return Column(
                crossAxisAlignment: .stretch,
                children: [
                  Padding(
                    padding: .symmetric(horizontal: 20.w),
                    child: MPInput(
                      controller: ref.read(keywordProvider.notifier).controller,
                      focusNode: ref.read(keywordProvider.notifier).focusNode,
                      onChanged: ref.read(keywordProvider.notifier).onChanged,
                      hintText: "지역(읍/면/동)을 입력해 주세요.",
                      innerRight: Row(
                        mainAxisSize: .min,
                        mainAxisAlignment: .end,
                        children: [
                          if (keyword.isNotEmpty) ...[
                            GestureDetector(
                              onTap: ref.read(birthProvider.notifier).onReset,
                              child: MPSvgImage(SvgImage.icReset, size: 24),
                            ),
                          ],
                          MPWidth(16),
                        ],
                      ),
                      innerRightConstraints: .tightForFinite(
                        width: (keyword.isNotEmpty ? 24.r : 0) + 16.w,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );

    state = "서울 강남구 역삼2동";
  }
}

@riverpod
bool onMoreEnabled(Ref ref) {
  final birth = ref.watch(birthProvider);
  final residence = ref.watch(residenceProvider);

  if (residence?.isEmpty ?? true) return false;
  if (!Valid.isBirthDate(birth)) return false;

  return true;
}

void onMore(WidgetRef ref) {
  final context = ref.context;

  context.unFocus();
  context.replaceRoute(RegisterCompleteRoute());
}
