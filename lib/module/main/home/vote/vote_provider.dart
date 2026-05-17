import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/model/bill.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vote_provider.g.dart';

@riverpod
class VotesPaging extends _$VotesPaging {
  CancelToken? _currentCancelToken;

  @override
  PagingState<int?, BillListData> build() => PagingState();

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
      final voteResult = ref.read(voteResultProvider);

      _currentCancelToken?.cancel();
      _currentCancelToken = CancelToken();

      final response = await ref
          .read(voteServiceProvider)
          .getMyVotedBills(
            sort: sort,
            page: newKey,
            voteResult: voteResult,
            cancelToken: _currentCancelToken,
          );

      final newItems = response.content
          .map((item) => item.toBillListData(ref))
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
class Sort extends _$Sort {
  @override
  MPSort build() => .popular;

  void onChanged(MPSort value) {
    if (state == value) return;
    state = value;

    ref.read(votesPagingProvider.notifier).onRefresh();
  }
}

@riverpod
class VoteResult extends _$VoteResult {
  @override
  bool? build() => null;

  void showBottomSheet(BuildContext context) => showBoolBottomSheetModal(
    context,
    value: state,
    onChanged: (value) {
      if (state == value) return;
      state = value;

      ref.read(votesPagingProvider.notifier).onRefresh();
    },
  );
}
