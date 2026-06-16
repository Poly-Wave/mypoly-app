import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/date_range.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/enum/stage.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/model/agenda.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_provider.g.dart';

@riverpod
class BookmarksPaging extends _$BookmarksPaging {
  CancelToken? _currentCancelToken;

  @override
  PagingState<int?, AgendaListData> build() => PagingState();

  Future<void> onRefresh() async {
    _currentCancelToken?.cancel();
    _currentCancelToken = null;
    state = PagingState();
  }

  Future<void> fetchNextPage() async {
    final prevState = state;

    if (prevState.isLoading) {
      return;
    }

    state = prevState.copyWith(isLoading: true, error: null);

    try {
      final lastKey = prevState.keys?.last;
      final newKey = lastKey != null ? lastKey + 1 : 0;

      final sort = ref.read(sortProvider);
      final categoryCodes = ref
          .read(categoriesProvider)
          .map((category) => category.code)
          .toList();

      final stageCodes = ref
          .read(stagesProvider)
          .map((stage) => stage.value)
          .toList();
      final createdAtRange = ref.read(createdAtRangeProvider);

      _currentCancelToken?.cancel();
      _currentCancelToken = CancelToken();

      final response = await ref
          .read(billBookmarkServiceProvider)
          .getBookmarkedBills(
            sort: sort,
            fromDate: createdAtRange.$2,
            toDate: createdAtRange.$3,
            categoryCodes: categoryCodes,
            stageCodes: stageCodes,
            page: newKey,
            cancelToken: _currentCancelToken,
          );

      final newItems = response.content
          .map((item) => item.toAgendaListData(ref))
          .toList();

      state = prevState.copyWith(
        isLoading: false,
        pages: [...?prevState.pages, newItems],
        keys: [...?prevState.keys, newKey],
        hasNextPage: response.hasNext,
      );
    } catch (e) {
      state = prevState.copyWith(isLoading: false, error: e);
    }
  }
}

@riverpod
class CreatedAtRange extends _$CreatedAtRange {
  @override
  (MPDateRange, DateTime?, DateTime?) build() => (.all, null, null);

  void showBottomSheet(BuildContext context) => showDateRangeBottomSheetModal(
    context,
    values: MPDateRange.values,
    value: state,
    title: "날짜",
    onChanged: (value) {
      if (state == value) return;
      state = value;

      ref.read(bookmarksPagingProvider.notifier).onRefresh();
    },
  );
}

@riverpod
class Sort extends _$Sort {
  @override
  MPSort build() => .popular;

  void onChanged(MPSort value) {
    if (state == value) return;
    state = value;

    ref.read(bookmarksPagingProvider.notifier).onRefresh();
  }
}

@riverpod
class Stages extends _$Stages {
  @override
  List<Stage> build() => [];

  void showBottomSheet(BuildContext context) => showWrapBottomSheetModal(
    context,
    multiple: true,
    title: "진행단계",
    values: Stage.values.map((stage) => (stage, stage.text)).toList(),
    value: state,
    onChanged: (value) {
      if (state == value) return;
      state = value;

      ref.read(bookmarksPagingProvider.notifier).onRefresh();
    },
  );
}

@riverpod
class Categories extends _$Categories {
  @override
  List<CategoryResponse> build() => [];

  void showBottomSheet(BuildContext context) => showWrapBottomSheetModal(
    context,
    multiple: true,
    values: ref
        .read(appCategoriesProvider)
        .map((item) => (item, item.name))
        .toList(),
    value: state,
    onChanged: (value) {
      if (state == value) return;
      state = value;

      ref.read(bookmarksPagingProvider.notifier).onRefresh();
    },
  );
}
