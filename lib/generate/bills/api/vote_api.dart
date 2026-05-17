//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/error_response.dart';
import 'package:mypoly/generate/bills/model/my_voted_bill_slice_response.dart';
import 'package:mypoly/generate/bills/model/user_bill_vote_request.dart';

part 'vote_api.g.dart';

@RestApi()
abstract class VoteApi {
  factory VoteApi(Dio dio, {String? baseUrl}) = _VoteApi;

  /// 참여한 투표 안건 목록 조회
  /// 로그인 사용자가 참여한 투표 안건 목록을 조회합니다.  - 날짜 필터는 &#39;투표한 날짜&#39; 기준입니다. - voteResults는 현재 사용자의 투표 결과 기준입니다. 사용 가능 값: AGREE, DISAGREE - sortType 기본값은 LATEST입니다. - 정렬은 pageable.sort가 아닌 sortType으로 제어합니다. - 사용 가능 값: LATEST, POPULAR
  ///
  /// Parameters:
  /// * [fromDate] - 투표 시작일, KST 기준
  /// * [toDate] - 투표 종료일, KST 기준
  /// * [voteResults] - 투표 결과 목록
  /// * [sortType] - 정렬 방식 (LATEST: 최근 투표순, POPULAR: 인기순)
  /// * [page] - 페이지 번호, 0부터 시작
  /// * [size] - 페이지 크기
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/votes/me')
  Future<MyVotedBillSliceResponse> getMyVotedBills({
    @Query('fromDate') DateTime? fromDate,
    @Query('toDate') DateTime? toDate,
    @Query('voteResults') List<String>? voteResults,
    @Query('sortType') String? sortType = 'LATEST',
    @Query('page') int? page = 0,
    @Query('size') int? size = 20,
    CancelToken? cancelToken,
  });

  /// 의안 투표 저장/수정
  /// 로그인 사용자의 의안 투표를 저장합니다. 이미 투표한 의안이면 기존 투표 결과를 수정합니다.
  ///
  /// Parameters:
  /// * [billId] - 의안 ID
  /// * [userBillVoteRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/votes/{billId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> voteOnBill({
    @Path('billId') required int billId,
    @Body() required UserBillVoteRequest userBillVoteRequest,
    CancelToken? cancelToken,
  });
}
