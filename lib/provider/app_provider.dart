import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypoly/constant/storage_key.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/flavor.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:mypoly/model/env.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_provider.g.dart';

@riverpod
Flavor flavor(Ref ref) => throw UnimplementedError();

@riverpod
FlutterSecureStorage secureStorage(Ref ref) => throw UnimplementedError();

@riverpod
SharedPreferences localStorage(Ref ref) => throw UnimplementedError();

@riverpod
PackageInfo packageInfo(Ref ref) => throw UnimplementedError();

@riverpod
Env env(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
class AppTerms extends _$AppTerms {
  @override
  List<TermsResponse> build() => [];

  Future<void> fetch() async =>
      state = await ref.read(termsServiceProvider).getTerms();
}

@Riverpod(keepAlive: true)
class AppCategories extends _$AppCategories {
  @override
  List<CategoryResponse> build() => [];

  Future<void> fetch() async =>
      state = await ref.read(categoryServiceProvider).getCategories();
}

@Riverpod(keepAlive: true)
class AppUserCategories extends _$AppUserCategories {
  @override
  List<CategoryResponse> build() => [];

  Future<void> fetch() async =>
      state = await ref.read(categoryServiceProvider).getMyCategories();

  void update(List<CategoryResponse> value) => state = value;

  void reset() => state = [];
}

@Riverpod(keepAlive: true)
class AppAccessToken extends _$AppAccessToken {
  @override
  String? build() => null;

  Future<void> init() async => state = await ref
      .read(secureStorageProvider)
      .read(key: StorageKey.accessToken);

  Future<void> reset() async {
    await ref.read(secureStorageProvider).delete(key: StorageKey.accessToken);
    state = null;
  }

  Future<void> update(String value) async {
    await ref
        .read(secureStorageProvider)
        .write(key: StorageKey.accessToken, value: value);
    state = value;
  }
}

@Riverpod(keepAlive: true)
class AppRefreshToken extends _$AppRefreshToken {
  @override
  String? build() => null;

  Future<void> init() async => state = await ref
      .read(secureStorageProvider)
      .read(key: StorageKey.refreshToken);

  Future<void> reset() async {
    await ref.read(secureStorageProvider).delete(key: StorageKey.refreshToken);
    state = null;
  }

  Future<void> update(String value) async {
    await ref
        .read(secureStorageProvider)
        .write(key: StorageKey.refreshToken, value: value);
    state = value;
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
