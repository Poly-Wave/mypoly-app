//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/users/model/onboarding_reminder_user_response.dart';

part 'internal_user_segment_api.g.dart';

@RestApi()
abstract class InternalUserSegmentApi {
  factory InternalUserSegmentApi(Dio dio, {String? baseUrl}) =
      _InternalUserSegmentApi;

  /// [Internal] 온보딩 완료 유저 전원 조회
  /// profile_completed_at !&#x3D; null 인 유저 전원을 반환한다. 행 3·4·5 의 fan-out 알림 대상이다.
  ///
  /// Parameters:
  /// * [xInternalApiKey] - 서비스 간 internal 공유 키
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/internal/segments/onboarding-completed')
  Future<List<OnboardingReminderUserResponse>> getOnboardingCompletedTargets({
    @Header('xInternalApiKey') required String xInternalApiKey,
    CancelToken? cancelToken,
  });

  /// [Internal] 온보딩 리마인더 발급 대상 조회
  /// type &#x3D; NICKNAME : 별명 설정 완료 + 관심 주제 미선택 + nickname_set_at &lt; before type &#x3D; CATEGORY : 관심 주제 선택 완료 + 추가 정보 미입력 + category_set_at &lt; before
  ///
  /// Parameters:
  /// * [xInternalApiKey] - 서비스 간 internal 공유 키
  /// * [type] - 세그먼트 타입
  /// * [before] - cutoff 시각(이 시각 이전에 마일스톤 도달한 유저)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/internal/segments/onboarding-reminder')
  Future<List<OnboardingReminderUserResponse>> getOnboardingReminderTargets({
    @Header('xInternalApiKey') required String xInternalApiKey,
    @Query('type') required String type,
    @Query('before') required DateTime before,
    CancelToken? cancelToken,
  });
}
