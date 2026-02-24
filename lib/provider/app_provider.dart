import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypoly/enum/flavor.dart';
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
