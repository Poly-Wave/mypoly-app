import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class Env {
  final String apiUrl;

  final String kakaoJsKey;
  final String kakaoNativeKey;

  const Env({
    required this.apiUrl,
    required this.kakaoJsKey,
    required this.kakaoNativeKey,
  });

  void init() =>
      KakaoSdk.init(nativeAppKey: kakaoNativeKey, javaScriptAppKey: kakaoJsKey);
}
