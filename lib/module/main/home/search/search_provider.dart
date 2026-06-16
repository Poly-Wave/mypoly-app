import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mypoly/constant/storage_key.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/model/agenda.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class SearchPaging extends _$SearchPaging {
  CancelToken? _currentCancelToken;

  @override
  PagingState<int?, AgendaListData>? build() => null;

  Future<void> onRefresh() async {
    _currentCancelToken?.cancel();
    _currentCancelToken = null;
    state = PagingState();
  }

  Future<void> onReset() async {
    _currentCancelToken?.cancel();
    _currentCancelToken = null;
    state = null;
  }

  Future<void> fetchNextPage() async {
    final prevState = state;

    if (prevState == null || prevState.isLoading) {
      return;
    }

    state = prevState.copyWith(isLoading: true, error: null);

    try {
      final lastKey = prevState.keys?.last;
      final newKey = lastKey != null ? lastKey + 1 : 0;

      final keyword = ref.read(keywordProvider);

      _currentCancelToken?.cancel();
      _currentCancelToken = CancelToken();

      final response = await ref
          .read(agendaServiceProvider)
          .searchAgendas(
            keyword: keyword,
            page: newKey,
            cancelToken: _currentCancelToken,
          );

      final newItems = response.content
          .map((item) => item.toAgendaListData(ref))
          .toList();

      ref.read(lastKeywordProvider.notifier).update(keyword);

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
class LastKeyword extends _$LastKeyword {
  @override
  String build() => "";

  void update(String value) => state = value;
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

  Future<void> onSubmitted(String value) async {
    if (value.isEmpty) {
      state = "";
      ref.read(searchPagingProvider.notifier).onReset();
      return;
    }

    await ref.read(appKeywordsProvider.notifier).add(value);

    state = value;

    ref.read(searchPagingProvider.notifier).onRefresh();
  }

  void onSet(String value) {
    controller.text = value;
    state = value;

    ref.read(searchPagingProvider.notifier).onRefresh();
  }

  void onReset() {
    controller.text = "";
    state = "";
    ref.read(searchPagingProvider.notifier).onReset();
  }
}

@Riverpod(keepAlive: true)
class AppKeywords extends _$AppKeywords {
  @override
  List<String> build() => [];

  Future<void> init() async {
    final value = await ref
        .read(secureStorageProvider)
        .read(key: StorageKey.keywords);

    if (value == null) {
      state = [];
      return;
    }

    final decoded = jsonDecode(value);
    state = decoded is List ? decoded.whereType<String>().toList() : [];
  }

  Future<void> reset() async {
    await ref.read(secureStorageProvider).delete(key: StorageKey.keywords);
    state = [];
  }

  Future<void> add(String value) async {
    final keyword = value.trim();

    if (keyword.isEmpty) return;

    final next = [keyword, ...state.where((item) => item != keyword)];
    await _save(next);
  }

  Future<void> delete(String value) async {
    final next = state.where((item) => item != value).toList();
    await _save(next);
  }

  Future<void> _save(List<String> value) async {
    await ref
        .read(secureStorageProvider)
        .write(key: StorageKey.keywords, value: jsonEncode(value));
    state = value;
  }
}
