import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/date_range.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/model/agenda.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vote_provider.g.dart';

@riverpod
class VotesPaging extends _$VotesPaging {
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
      final voteResult = ref.read(voteResultProvider);
      final createdAtRange = ref.read(createdAtRangeProvider);
      final votedAtRange = ref.read(votedAtRangeProvider);

      _currentCancelToken?.cancel();
      _currentCancelToken = CancelToken();

      final response = await ref
          .read(voteServiceProvider)
          .getMyVotedBills(
            sort: sort,
            page: newKey,
            voteResult: voteResult,
            proposalFromDate: createdAtRange.$2,
            proposalToDate: createdAtRange.$3,
            votedFromDate: votedAtRange.$2,
            votedToDate: votedAtRange.$3,
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
    title: "안건 생성일",
    onChanged: (value) {
      if (state == value) return;
      state = value;

      ref.read(votesPagingProvider.notifier).onRefresh();
    },
  );
}

@riverpod
class VotedAtRange extends _$VotedAtRange {
  @override
  (MPDateRange, DateTime?, DateTime?) build() => (.all, null, null);

  void showBottomSheet(BuildContext context) => showDateRangeBottomSheetModal(
    context,
    values: MPDateRange.values,
    value: state,
    title: "투표 날짜",
    onChanged: (value) {
      if (state == value) return;
      state = value;

      ref.read(votesPagingProvider.notifier).onRefresh();
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
