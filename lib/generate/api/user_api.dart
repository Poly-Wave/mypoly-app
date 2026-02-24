//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//


import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/model/update_onboarding_status_request.dart';
import 'package:mypoly/generate/model/user_update_profile_request.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String? baseUrl}) = _UserApi;


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


  /// 주소 검색
  /// 행정구역(시도/시군구/읍면동) 주소 검색 결과를 반환합니다. DB에서 직접 조회하며, 검색어에 해당하는 읍면동 정보를 포함합니다.  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요. 
  ///
  /// Parameters:
  /// * [keyword] - 검색어 (시도, 시군구, 읍면동)
  /// * [currentPage] - 현재 페이지 번호
  /// * [countPerPage] - 페이지당 출력 개수
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/addresses')
  Future<void> searchAddress({ 
    @Query('keyword') required String keyword,
    @Query('currentPage') String? currentPage = '1',
    @Query('countPerPage') String? countPerPage = '10',
    CancelToken? cancelToken,
  });


  /// 온보딩 상태 업데이트
  /// 사용자 온보딩 상태를 업데이트할 때 호출. JWT로 본인 확인 후 path의 userId와 일치할 때만 수정 가능.  인증 - JWT 인증이 필요합니다. - bill-service 호출 시 클라이언트의 Authorization 헤더를 그대로 전달하세요. 
  ///
  /// Parameters:
  /// * [userId] - 사용자 ID
  /// * [updateOnboardingStatusRequest] - 업데이트할 온보딩 상태
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/users/{userId}/onboarding-status')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<void> updateOnboardingStatus({ 
    @Path('userId') required int userId,
    @Body() required UpdateOnboardingStatusRequest updateOnboardingStatusRequest,
    CancelToken? cancelToken,
  });


  /// 사용자 프로필 수정
  /// 사용자의 성별, 생년월일, 거주지역(시도/시군구/읍면동) 정보를 수정합니다.  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요. 
  ///
  /// Parameters:
  /// * [userUpdateProfileRequest] - 수정할 프로필 정보
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/me/profile')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<void> updateProfile({ 
    @Body() required UserUpdateProfileRequest userUpdateProfileRequest,
    CancelToken? cancelToken,
  });

}

