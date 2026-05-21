//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/bill_stage_change_response.dart';
import 'package:mypoly/generate/bills/model/bookmarked_unvoted_bill_response.dart';
import 'package:mypoly/generate/bills/model/user_interest_agenda_count_response.dart';

part 'internal_bill_segment_api.g.dart';

@RestApi()
abstract class InternalBillSegmentApi {
  factory InternalBillSegmentApi(Dio dio, {String? baseUrl}) =
      _InternalBillSegmentApi;

  /// [Internal] 북마크된 의안의 최근 단계 전이
  /// since 이후 단계가 변경된 의안 × 그 시점 이전에 북마크한 사용자. 행 6 (북마크 단계 변경 실시간) 알림 발급 대상.
  ///
  /// Parameters:
  /// * [xInternalApiKey] - 서비스 간 internal 공유 키
  /// * [since] - 이 시각 이후 발생한 전이만 반환
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/internal/segments/bookmarked-stage-changes')
  Future<List<BillStageChangeResponse>> getBookmarkedStageChanges({
    @Header('xInternalApiKey') required String xInternalApiKey,
    @Query('since') required DateTime since,
    CancelToken? cancelToken,
  });

  /// [Internal] 북마크 D+1 미투표 (user, bill) 쌍 조회
  /// 북마크 저장 시각이 before 이전이고, 같은 사용자가 그 의안에 아직 투표하지 않은 (user, bill) 쌍을 반환한다. 행 7 (북마크 저장 후 D+1일 미투표) 알림의 발급 대상.
  ///
  /// Parameters:
  /// * [xInternalApiKey] - 서비스 간 internal 공유 키
  /// * [before] - 북마크 저장 시각 cutoff(이 시각 이전에 북마크한 (user, bill) 쌍)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/internal/segments/bookmarked-unvoted')
  Future<List<BookmarkedUnvotedBillResponse>> getBookmarkedUnvotedTargets({
    @Header('xInternalApiKey') required String xInternalApiKey,
    @Query('before') required DateTime before,
    CancelToken? cancelToken,
  });

  /// [Internal] 관심 카테고리 매칭 신규 안건 카운트
  /// [from, to) 범위에 first_collected_at 이 들어간 안건 중 사용자의 관심 카테고리에 매칭되는 것의 개수를 사용자별로 집계. count &gt; 0 인 사용자만 결과에 포함된다. 행 3 (매일 09:00 관심 카테고리 매칭) 알림의 발급 대상.
  ///
  /// Parameters:
  /// * [xInternalApiKey] - 서비스 간 internal 공유 키
  /// * [from] - 수집 시작 시각 (inclusive)
  /// * [to] - 수집 종료 시각 (exclusive)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/internal/segments/interest-matched-counts')
  Future<List<UserInterestAgendaCountResponse>> getInterestMatchedCounts({
    @Header('xInternalApiKey') required String xInternalApiKey,
    @Query('from') required DateTime from,
    @Query('to') required DateTime to,
    CancelToken? cancelToken,
  });
}
