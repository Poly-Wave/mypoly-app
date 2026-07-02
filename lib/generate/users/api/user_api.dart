//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/users/model/address_search_response.dart';
import 'package:mypoly/generate/users/model/error_response.dart';
import 'package:mypoly/generate/users/model/nickname_availability_response.dart';
import 'package:mypoly/generate/users/model/onboarding_status_response.dart';
import 'package:mypoly/generate/users/model/random_nickname_response.dart';
import 'package:mypoly/generate/users/model/update_onboarding_status_request.dart';
import 'package:mypoly/generate/users/model/user_me_response.dart';
import 'package:mypoly/generate/users/model/user_update_basic_profile_request.dart';
import 'package:mypoly/generate/users/model/user_update_profile_request.dart';
import 'package:mypoly/generate/users/model/withdraw_me_request.dart';

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
  Future<NicknameAvailabilityResponse> checkNicknameAvailability({
    @Query('nickname') required String nickname,
    CancelToken? cancelToken,
  });

  /// [DEV/LOCAL] 내 계정 탈퇴
  /// 개발/테스트 환경에서만 임시로 사용하는 회원 탈퇴 API입니다.
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @DELETE('/dev-users/me')
  Future<void> deleteMe({CancelToken? cancelToken});

  /// 회원 탈퇴
  /// 로그인한 사용자를 즉시 탈퇴 처리합니다.
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/me/withdraw')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> withdrawMe({
    @Body() required WithdrawMeRequest withdrawMeRequest,
    CancelToken? cancelToken,
  });

  /// 내 정보 조회
  /// 로그인한 사용자의 정보를 조회합니다.  포함 정보 - 온보딩 상태 - 닉네임 - 프로필(성별/생년월일/프로필 이미지/주소)  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요.
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/me')
  Future<UserMeResponse> getMe({CancelToken? cancelToken});

  /// 온보딩 상태 조회
  /// 사용자의 온보딩 상태를 조회합니다.
  ///
  /// Parameters:
  /// * [userId] - 사용자 ID
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/{userId}/onboarding-status')
  Future<OnboardingStatusResponse> getOnboardingStatus({
    @Path('userId') required int userId,
    CancelToken? cancelToken,
  });

  /// 랜덤 닉네임 생성
  /// 서버에서 랜덤 닉네임을 생성해 반환합니다.  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요.
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/nicknames/random')
  Future<RandomNicknameResponse> getRandomNickname({CancelToken? cancelToken});

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
  Future<AddressSearchResponse> searchAddress({
    @Query('keyword') required String keyword,
    @Query('currentPage') String? currentPage = '1',
    @Query('countPerPage') String? countPerPage = '10',
    CancelToken? cancelToken,
  });

  /// 내 기본 정보 수정
  /// 로그인한 사용자의 기본 정보를 수정합니다. - 수정 항목: 별명, 성별, 생년월일, 거주지역(시도/시군구/읍면동) - 온보딩이 완료된(COMPLETE) 사용자만 호출할 수 있습니다. - 닉네임 변경 시 금칙어/중복 검사가 적용됩니다. - 온보딩 상태는 변경되지 않습니다.  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요.
  ///
  /// Parameters:
  /// * [userUpdateBasicProfileRequest] - 수정할 기본 정보
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/me/basic-profile')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> updateBasicProfile({
    @Body()
    required UserUpdateBasicProfileRequest userUpdateBasicProfileRequest,
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
  @PATCH('/{userId}/onboarding-status')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> updateOnboardingStatus({
    @Path('userId') required int userId,
    @Body()
    required UpdateOnboardingStatusRequest updateOnboardingStatusRequest,
    CancelToken? cancelToken,
  });

  /// 사용자 프로필 수정
  /// 사용자의 성별, 생년월일, 거주지역(시도/시군구/읍면동) 정보를 수정합니다. - 온보딩 상태가 CATEGORY일 때만 수정 가능합니다. - 수정 성공 시 온보딩 상태는 COMPLETE로 자동 변경됩니다.  인증 - JWT 인증이 필요합니다. - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요.
  ///
  /// Parameters:
  /// * [userUpdateProfileRequest] - 수정할 프로필 정보
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @PATCH('/me/profile')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> updateProfile({
    @Body() required UserUpdateProfileRequest userUpdateProfileRequest,
    CancelToken? cancelToken,
  });
}
