import 'package:dio/dio.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/generate/bills/api/vote_api.dart';
import 'package:mypoly/generate/bills/model/my_voted_bill_slice_response.dart';
import 'package:mypoly/generate/bills/model/user_bill_vote_request.dart';
import 'package:mypoly/util/error.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class VoteService {
  // ignore: unused_field
  final Ref _ref;
  final VoteApi _voteApi;

  VoteService(this._ref, this._voteApi);

  Future<MyVotedBillSliceResponse> getMyVotedBills({
    DateTime? proposalFromDate,
    DateTime? proposalToDate,
    DateTime? votedFromDate,
    DateTime? votedToDate,
    required MPSort sort,
    bool? voteResult,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _voteApi.getMyVotedBills(
        proposalFromDate: proposalFromDate?.toDashYMD,
        proposalToDate: proposalToDate?.toDashYMD,
        votedFromDate: votedFromDate?.toDashYMD,
        votedToDate: votedToDate?.toDashYMD,
        sortType: sort.value,
        voteResults: voteResult != null
            ? [voteResult ? "AGREE" : "DISAGREE"]
            : null,
        page: page,
        size: size,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<void> voteOnBill({required int billId, required bool vote}) async {
    try {
      await _voteApi.voteOnBill(
        billId: billId,
        userBillVoteRequest: UserBillVoteRequest(
          voteResult: vote ? .agree : .disagree,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }
}
