import 'package:mypoly/generate/users/model/social_token_login_request.dart';
import 'package:mypoly/generate/users/model/social_token_signup_request.dart';

enum SocialProvider {
  kakao(text: "카카오"),
  apple(text: "애플"),
  google(text: "구글");

  final String text;

  const SocialProvider({required this.text});

  static SocialProvider fromString(String value) {
    switch (value.toLowerCase()) {
      case 'apple':
        return .apple;
      case 'google':
        return .google;
      case 'kakao':
      default:
        return .kakao;
    }
  }
}

enum SocialTokenType {
  accessToken(login: .accessToken, register: .accessToken),
  idToken(login: .idToken, register: .idToken);

  final SocialTokenLoginRequestTokenTypeEnum login;
  final SocialTokenSignupRequestTokenTypeEnum register;

  const SocialTokenType({required this.login, required this.register});
}
