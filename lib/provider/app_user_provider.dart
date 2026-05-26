import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/gender.dart';
import 'package:mypoly/enum/social.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/users/model/terms_agreement_request.dart';
import 'package:mypoly/generate/users/model/user_me_response.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/util/extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user_provider.g.dart';

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

    await Future.wait([ref.read(appUserCategoriesProvider.notifier).fetch()]);

    return response;
  }

  Future<void> updateProfile({
    required String nickname,
    required Gender gender,
    required String birthDate,
    required String sido,
    required String sigungu,
    required String emdName,
  }) async {
    await ref
        .read(userServiceProvider)
        .updateProfile(
          nickname: nickname,
          gender: gender,
          birthDate: birthDate,
          sido: sido,
          sigungu: sigungu,
          emdName: emdName,
        );

    state = state?.copyWith(
      nickname: nickname,
      gender: gender.me,
      birthDate: birthDate,
      sido: sido,
      sigungu: sigungu,
      emdName: emdName,
    );
  }

  Future<void> updateCategories(List<CategoryResponse> value) async {
    await ref
        .read(categoryServiceProvider)
        .updateCategories(categories: value, isOnboard: false);

    ref.read(appUserCategoriesProvider.notifier).update(value);
  }

  Future<void> logout() async {
    await Future.wait([
      ref.read(appAccessTokenProvider.notifier).reset(),
      ref.read(appRefreshTokenProvider.notifier).reset(),
      ref.read(appKeywordsProvider.notifier).reset(),
    ]);

    ref.read(appUserCategoriesProvider.notifier).reset();

    final router = ref.read(routerProvider);

    if (router.current.name != SplashRoute.name) {
      ref.read(routerProvider).replaceAll([OnboardRoute()]);
    }

    state = null;
  }
}

@riverpod
SocialProvider appUserSocialProvider(Ref ref) =>
    SocialProvider.fromString(ref.watch(appUserProvider)?.provider ?? "");

@riverpod
String appUserNickname(Ref ref) => ref.watch(appUserProvider)?.nickname ?? "";

@riverpod
Gender appUserGender(Ref ref) => Gender.fromUserMeResponseGenderEnum(
  ref.watch(appUserProvider)?.gender ?? .man,
);

@riverpod
int appUserAge(Ref ref) => ref.watch(appUserProvider)?.birthDate?.age ?? 0;

@riverpod
String appUserAddress(Ref ref) => ref.watch(appUserProvider)?.address ?? "";
