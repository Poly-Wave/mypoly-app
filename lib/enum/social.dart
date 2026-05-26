import 'package:mypoly/asset/index.dart';
import 'package:mypoly/generate/users/model/social_token_login_request.dart';
import 'package:mypoly/generate/users/model/social_token_signup_request.dart';

enum SocialProvider {
  kakao(text: "카카오", imageCircle: SvgImage.socialKakaoCircle),
  apple(text: "애플", imageCircle: SvgImage.socialAppleCircle),
  google(text: "구글", imageCircle: SvgImage.socialGoogleCircle);

  final String text;
  final String imageCircle;

  const SocialProvider({required this.text, required this.imageCircle});

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
