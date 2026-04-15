//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/bill_detail_response.dart';
import 'package:mypoly/generate/bills/model/bill_status_history_response.dart';
import 'package:mypoly/generate/bills/model/bill_vote_summary_response.dart';
import 'package:mypoly/generate/bills/model/error_response.dart';
import 'package:mypoly/generate/bills/model/similar_topic_bill_response.dart';

part 'bill_detail_api.g.dart';

@RestApi()
abstract class BillDetailApi {
  factory BillDetailApi(Dio dio, {String? baseUrl}) = _BillDetailApi;

  /// 의안 상세 조회
  /// 의안 상세 화면에 필요한 기본 정보, AI 요약, 카테고리, 현재 단계, 투표 요약 정보를 반환합니다.
  ///
  /// Parameters:
  /// * [billId] - 의안 ID
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/{billId}')
  Future<BillDetailResponse> getBillDetail({
    @Path('billId') required int billId,
    CancelToken? cancelToken,
  });

  /// 의안 상태 이력 조회
  /// 의안의 심사 진행 단계 이력을 반환합니다.
  ///
  /// Parameters:
  /// * [billId] - 의안 ID
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/{billId}/status-history')
  Future<List<BillStatusHistoryResponse>> getBillStatusHistory({
    @Path('billId') required int billId,
    CancelToken? cancelToken,
  });

  /// 의안 투표 요약 조회
  /// 현재 사용자의 투표 여부/투표값과 전체 찬반 집계 정보를 반환합니다.
  ///
  /// Parameters:
  /// * [billId] - 의안 ID
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/{billId}/vote-summary')
  Future<BillVoteSummaryResponse> getBillVoteSummary({
    @Path('billId') required int billId,
    CancelToken? cancelToken,
  });

  /// 유사 주제 의안 목록 조회
  /// 현재 의안의 대표 카테고리(rank 1) 기준으로 유사 주제 의안을 조회합니다. sortType - RELEVANT: 같은 대표 카테고리 + 최신순 - HOT_DEBATE: 같은 대표 카테고리 + 찬반이 팽팽한 순 - TRENDING: 같은 대표 카테고리 + 최근 7일 스냅샷 인기순 - MONTHLY_POPULAR: 같은 대표 카테고리 + 최근 30일 투표 수 순
  ///
  /// Parameters:
  /// * [billId] - 기준 의안 ID
  /// * [sortType] - 정렬 방식
  /// * [size] - 조회 개수
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/{billId}/similar-topics')
  Future<List<SimilarTopicBillResponse>> getSimilarTopics({
    @Path('billId') required int billId,
    @Query('sortType') String? sortType,
    @Query('size') int? size = 5,
    CancelToken? cancelToken,
  });
}
