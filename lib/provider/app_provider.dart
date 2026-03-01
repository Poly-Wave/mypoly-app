import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  List<TermsResponse>? build() => null;

  Future<void> fetch() async =>
      state = await ref.read(termsServiceProvider).getTerms();

  void reset() => state = null;
}

@Riverpod(keepAlive: true)
class AppCategories extends _$AppCategories {
  @override
  List<CategoryResponse>? build() => null;

  Future<void> fetch() async =>
      state = await ref.read(categoryServiceProvider).getCategories();

  void reset() => state = null;
}
