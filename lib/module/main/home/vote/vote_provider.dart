import 'package:flutter/material.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vote_provider.g.dart';

@riverpod
class Sort extends _$Sort {
  @override
  MPSort build() => .popular;

  void onChanged(MPSort value) => state = value;
}

@riverpod
class VoteResult extends _$VoteResult {
  @override
  bool? build() => null;

  void showBottomSheet(BuildContext context) {
    showBoolBottomSheetModal(
      context,
      value: state,
      onChanged: (value) => state = value,
    );
  }
}
