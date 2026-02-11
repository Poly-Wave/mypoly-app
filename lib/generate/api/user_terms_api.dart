//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//


import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/model/user_agreement_request.dart';

part 'user_terms_api.g.dart';

@RestApi()
abstract class UserTermsApi {
  factory UserTermsApi(Dio dio, {String? baseUrl}) = _UserTermsApi;


  /// 약관 동의 저장(업서트)
  /// 로그인 사용자의 약관 동의 정보를 저장합니다. (JWT 인증 필요)  동작 규칙(업서트) - (user_id, terms_id) 기준으로 **있으면 update**, 없으면 **insert** - 요청에 포함되지 않은 다른 약관 동의 내역은 **삭제하지 않습니다** - 요청 본문에 **중복 termId가 있으면 400** 처리합니다. (DB 유니크 충돌 방지)  예외 정책(실제 코드 기준) - 요청 값 검증 실패: 400 - 유효하지 않은 약관 ID 포함: 400 - 사용자 없음: 404 - 인증 필요: 401 / 권한 없음: 403 
  ///
  /// Parameters:
  /// * [userAgreementRequest] - 약관 동의 목록(업서트 대상)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/user-terms/agree')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<void> agreeToTerms({ 
    @Body() required UserAgreementRequest userAgreementRequest,
    CancelToken? cancelToken,
  });

}

