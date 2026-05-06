import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class Env {
  final String usersApiUrl;
  final String billsApiUrl;

  final String kakaoJsKey;
  final String kakaoNativeKey;

  Env({
    required String baseApiUrl,
    required this.kakaoJsKey,
    required this.kakaoNativeKey,
  }) : usersApiUrl = "$baseApiUrl/users",
       billsApiUrl = "$baseApiUrl/bills";

  void init() =>
      KakaoSdk.init(nativeAppKey: kakaoNativeKey, javaScriptAppKey: kakaoJsKey);
}
