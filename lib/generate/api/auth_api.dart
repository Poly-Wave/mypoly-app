//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//


import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;


  /// 소셜 로그인 시작(302 리다이렉트)
  /// 이 API는 OAuth2 로그인 플로우를 시작시키는 **리다이렉트 엔드포인트**입니다. (302 + Location)  Swagger UI의 Execute는 브라우저 fetch 기반이라 리다이렉트를 따라가며, 외부 도메인(카카오)으로 넘어가는 과정에서 CORS/쿠키 이슈로 중간 302가 깔끔히 보이지 않을 수 있습니다.  확인/테스트 방법 - 브라우저 주소창에서 직접 &#x60;/users/auth/kakao&#x60; 접속 - 또는 &#x60;curl -v&#x60;로 Location 헤더를 확인  로그인 성공 시 최종적으로 서버가 JSON으로 JWT를 내려줍니다(OAuth2 success handler가 응답). 
  ///
  /// Parameters:
  /// * [provider] - 현재 지원 provider
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/auth/{provider}')
  Future<void> start({ 
    @Path('provider') required String provider,
    CancelToken? cancelToken,
  });

}

