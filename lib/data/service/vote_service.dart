import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/generate/bills/api/vote_api.dart';
import 'package:mypoly/generate/bills/model/my_voted_bill_slice_response.dart';
import 'package:mypoly/util/error.dart';
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
        proposalFromDate: proposalFromDate,
        proposalToDate: proposalToDate,
        votedFromDate: votedFromDate,
        votedToDate: votedToDate,
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
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
