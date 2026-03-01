//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/users/model/error_response.dart';
import 'package:mypoly/generate/users/model/social_login_response.dart';
import 'package:mypoly/generate/users/model/social_token_login_request.dart';
import 'package:mypoly/generate/users/model/social_token_signup_request.dart';

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

  /// SDK 토큰 검증 기반 로그인(JWT 발급)
  /// 앱에서 SDK로 소셜 로그인 → access_token 또는 id_token을 받은 뒤, 서버에 전달하면 서버가 검증 후 우리 서비스 JWT를 발급합니다.  provider별 권장 토큰 타입 - kakao: ACCESS_TOKEN - google/apple: (현재 템플릿) ID_TOKEN 위주로 확장 예정  Swagger만으로 테스트(추천) - dev/local: &#x60;POST /dev-auth/login&#x60; 으로 JWT 발급 → Authorize → 보호 API 테스트
  ///
  /// Parameters:
  /// * [provider] - provider
  /// * [socialTokenLoginRequest] - SDK에서 받은 토큰을 전달합니다. - tokenType: ACCESS_TOKEN | ID_TOKEN - token: 실제 토큰 문자열
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/{provider}/token')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<SocialLoginResponse> loginWithToken({
    @Path('provider') required String provider,
    @Body() required SocialTokenLoginRequest socialTokenLoginRequest,
    CancelToken? cancelToken,
  });

  /// 소셜 토큰 + 약관 + 닉네임 통합 회원가입
  /// SDK로 받은 소셜 토큰(kakao: ACCESS_TOKEN, google/apple: ID_TOKEN)과 사용자가 입력한 닉네임, 그리고 필수/선택 약관 동의 내역을 한 번에 서버에 전송합니다.  서버 검증(토큰 유효성, 닉네임 중복 등) 후, &#x60;User&#x60;, &#x60;UserOauth&#x60;, &#x60;UserTerms&#x60; 레코드를 생성하고 회원가입 완료 및 JWT 액세스 토큰을 반환합니다.  참고: &#x60;/auth/{provider}/token&#x60;으로 로그인 실패 시 반환되는 코드(또는 HTTP 상태 등 클라이언트 협의)를 보고 이 API로 분기합니다.
  ///
  /// Parameters:
  /// * [provider] - provider (kakao, google, apple 등)
  /// * [socialTokenSignupRequest] - 토큰 타입, 토큰 값, 새로운 닉네임, 동의한 약관 목록의 JSON
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/auth/{provider}/signup')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<SocialLoginResponse> signupWithToken({
    @Path('provider') required String provider,
    @Body() required SocialTokenSignupRequest socialTokenSignupRequest,
    CancelToken? cancelToken,
  });
}
