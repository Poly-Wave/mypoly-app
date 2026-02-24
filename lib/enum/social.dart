import 'package:mypoly/generate/model/social_token_login_request.dart';
import 'package:mypoly/generate/model/social_token_signup_request.dart';

enum SocialProvider { kakao, apple, google }

enum SocialTokenType {
  accessToken(login: .accessToken, register: .accessToken),
  idToken(login: .idToken, register: .idToken);

  final SocialTokenLoginRequestTokenTypeEnum login;
  final SocialTokenSignupRequestTokenTypeEnum register;

  const SocialTokenType({required this.login, required this.register});
}
