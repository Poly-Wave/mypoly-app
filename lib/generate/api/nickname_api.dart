//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//


import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/model/nickname_create_request.dart';

part 'nickname_api.g.dart';

@RestApi()
abstract class NicknameApi {
  factory NicknameApi(Dio dio, {String? baseUrl}) = _NicknameApi;


  /// 내 닉네임 설정
  /// 로그인 사용자의 닉네임을 설정(또는 변경)합니다.  예외 정책 - 요청 값 검증 실패: 400 - 금칙어 포함: 400 - 중복 닉네임: 409 - 사용자 없음: 404  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요. 
  ///
  /// Parameters:
  /// * [nicknameCreateRequest] - 설정할 닉네임
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/me/nickname')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<void> assignNickname({ 
    @Body() required NicknameCreateRequest nicknameCreateRequest,
    CancelToken? cancelToken,
  });


  /// 닉네임 사용 가능 여부 조회
  /// 쿼리 파라미터 &#x60;nickname&#x60;으로 닉네임 사용 가능 여부를 반환합니다.  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요. 
  ///
  /// Parameters:
  /// * [nickname] - 검사할 닉네임
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/nicknames/availability')
  Future<void> checkNicknameAvailability({ 
    @Query('nickname') required String nickname,
    CancelToken? cancelToken,
  });


  /// 랜덤 닉네임 생성
  /// 서버에서 랜덤 닉네임을 생성해 반환합니다.  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요. 
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/nicknames/random')
  Future<void> getRandomNickname({ 
    CancelToken? cancelToken,
  });

}

