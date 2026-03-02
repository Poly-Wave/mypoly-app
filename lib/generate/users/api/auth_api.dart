//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/users/model/error_response.dart';
import 'package:mypoly/generate/users/model/social_login_response.dart';
import 'package:mypoly/generate/users/model/social_token_login_request.dart';
import 'package:mypoly/generate/users/model/social_token_signup_request.dart';
import 'package:mypoly/generate/users/model/token_refresh_request.dart';
import 'package:mypoly/generate/users/model/token_refresh_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  /// [DEV/LOCAL] Swagger 테스트용 JWT 발급
  /// 앱 없이 Swagger만으로 보호 API들을 테스트하기 위한 엔드포인트입니다. - social.dev-auth.enabled&#x3D;true 일 때만 활성화되는 걸 권장합니다. - &#x60;X-DEV-KEY&#x60; 헤더가 일치해야 합니다.  ✅ 사용 순서 1) &#x60;POST /dev-auth/login&#x60; 호출 → 응답의 &#x60;data.jwt&#x60; 복사 2) Swagger 우측 상단 Authorize → &#x60;Bearer {jwt}&#x60; 입력 3) 잠금 아이콘 API 호출
  ///
  /// Parameters:
  /// * [X_DEV_KEY] - DEV 키 (local 기본값: local-dev-key, 배포 시 DEV_AUTH_KEY로 주입)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/dev-auth/login')
  Future<SocialLoginResponse> devLogin({
    @Header('X_DEV_KEY') required String X_DEV_KEY,
    CancelToken? cancelToken,
  });

  /// SDK 토큰 검증 기반 로그인(Access/Refresh 발급)
  /// 앱에서 SDK로 소셜 로그인 후 받은 access_token 또는 id_token을 서버에 전달하면, 서버가 검증 후 우리 서비스 Access/Refresh 토큰을 발급합니다.
  ///
  /// Parameters:
  /// * [provider] - kakao/google/apple
  /// * [socialTokenLoginRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/token/{provider}/login')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<SocialLoginResponse> loginWithToken({
    @Path('provider') required String provider,
    @Body() required SocialTokenLoginRequest socialTokenLoginRequest,
    CancelToken? cancelToken,
  });

  /// Refresh Token으로 Access Token 재발급
  /// Access Token이 만료(401)된 경우, 앱은 Refresh Token을 사용해 새 Access Token을 발급받습니다.
  ///
  /// Parameters:
  /// * [tokenRefreshRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/refresh')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<TokenRefreshResponse> refresh({
    @Body() required TokenRefreshRequest tokenRefreshRequest,
    CancelToken? cancelToken,
  });

  /// SDK 토큰 검증 기반 회원가입(Access/Refresh 발급)
  ///
  ///
  /// Parameters:
  /// * [provider]
  /// * [socialTokenSignupRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/token/{provider}/signup')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<SocialLoginResponse> signupWithToken({
    @Path('provider') required String provider,
    @Body() required SocialTokenSignupRequest socialTokenSignupRequest,
    CancelToken? cancelToken,
  });
}
