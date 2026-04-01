//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/error_response.dart';
import 'package:mypoly/generate/bills/model/user_bill_vote_request.dart';

part 'vote_api.g.dart';

@RestApi()
abstract class VoteApi {
  factory VoteApi(Dio dio, {String? baseUrl}) = _VoteApi;

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
