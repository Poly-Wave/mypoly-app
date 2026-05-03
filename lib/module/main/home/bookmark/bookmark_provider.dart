import 'package:flutter/material.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_provider.g.dart';

@riverpod
class Sort extends _$Sort {
  @override
  MPSort build() => .popular;

  void onChanged(MPSort value) => state = value;
}

@riverpod
class Categories extends _$Categories {
  @override
  List<CategoryResponse> build() => [];

  void showBottomSheet(BuildContext context) => showWrapBottomSheetModal(
    context,
    values: ref
        .read(appCategoriesProvider)
        .map((item) => (item, item.name ?? ""))
        .toList(),
    value: state,
    onChanged: (value) => state = value,
  );
}
