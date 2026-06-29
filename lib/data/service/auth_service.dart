import 'package:dio/dio.dart';
import 'package:mypoly/enum/social.dart';
import 'package:mypoly/generate/users/api/auth_api.dart';
import 'package:mypoly/generate/users/model/social_login_response.dart';
import 'package:mypoly/generate/users/model/social_token_login_request.dart';
import 'package:mypoly/generate/users/model/social_token_signup_request.dart';
import 'package:mypoly/generate/users/model/terms_agreement_request.dart';
import 'package:mypoly/util/error.dart';
import 'package:mypoly/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthService {
  // ignore: unused_field
  final Ref _ref;
  final AuthApi _authApi;

  AuthService(this._ref, this._authApi);

  Future<SocialLoginResponse> signIn({
    required SocialProvider provider,
    required SocialTokenType tokenType,
    required String token,
  }) async {
    try {
      return await _authApi.loginWithToken(
        provider: provider.name,
        socialTokenLoginRequest: SocialTokenLoginRequest(
          tokenType: tokenType.login,
          token: token,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<SocialLoginResponse> signUp({
    required SocialProvider provider,
    required SocialTokenType tokenType,
    required String token,
    required String nickname,
    required List<TermsAgreementRequest> termAgreements,
  }) async {
    try {
      return await _authApi.signupWithToken(
        provider: provider.name,
        socialTokenSignupRequest: SocialTokenSignupRequest(
          tokenType: tokenType.register,
          token: token,
          nickname: nickname,
          termAgreements: termAgreements,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }
}
