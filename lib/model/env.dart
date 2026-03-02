import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class Env {
  final String baseApiUrl;
  final String usersApiUrl;
  final String buillsApiUrl;

  final String kakaoJsKey;
  final String kakaoNativeKey;

  Env({
    required this.baseApiUrl,
    required this.kakaoJsKey,
    required this.kakaoNativeKey,
  }) : usersApiUrl = "$baseApiUrl/users",
       buillsApiUrl = "$baseApiUrl/bills";

  void init() =>
      KakaoSdk.init(nativeAppKey: kakaoNativeKey, javaScriptAppKey: kakaoJsKey);
}
