import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypoly/constant/storage_key.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/flavor.dart';
import 'package:mypoly/enum/social.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/users/model/terms_agreement_request.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:mypoly/generate/users/model/user_me_response.dart';
import 'package:mypoly/model/env.dart';
import 'package:mypoly/provider/router_provider.dart';
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
class AppUser extends _$AppUser {
  @override
  UserMeResponse? build() => null;

  Future<UserMeResponse> signIn({
    required SocialProvider provider,
    required SocialTokenType tokenType,
    required String token,
  }) async {
    final response = await ref
        .read(authServiceProvider)
        .signIn(provider: provider, tokenType: tokenType, token: token);

    await Future.wait([
      ref.read(appAccessTokenProvider.notifier).update(response.jwt),
      ref.read(appRefreshTokenProvider.notifier).update(response.refreshToken),
    ]);

    return await fetch();
  }

  Future<UserMeResponse> signUp({
    required SocialProvider provider,
    required SocialTokenType tokenType,
    required String token,
    required String nickname,
    required List<TermsAgreementRequest> terms,
  }) async {
    final response = await ref
        .read(authServiceProvider)
        .signUp(
          provider: provider,
          tokenType: tokenType,
          token: token,
          nickname: nickname,
          termAgreements: terms,
        );

    await Future.wait([
      ref.read(appAccessTokenProvider.notifier).update(response.jwt),
      ref.read(appRefreshTokenProvider.notifier).update(response.refreshToken),
    ]);

    return await fetch();
  }

  Future<UserMeResponse> fetch() async {
    final response = await ref.read(userServiceProvider).getMe();

    state = response;

    return response;
  }

  Future<void> logout() async {
    await Future.wait([
      ref.read(appAccessTokenProvider.notifier).reset(),
      ref.read(appRefreshTokenProvider.notifier).reset(),
    ]);

    final router = ref.read(routerProvider);

    if (router.current.name != SplashRoute.name) {
      ref.read(routerProvider).replaceAll([OnboardRoute()]);
    }

    state = null;
  }
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
