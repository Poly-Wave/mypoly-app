import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/generate/bills/api/bill_bookmark_api.dart';
import 'package:mypoly/generate/bills/model/slice_response_bookmarked_bill_response.dart';
import 'package:mypoly/util/error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class BillBookmarkService {
  // ignore: unused_field
  final Ref _ref;
  final BillBookmarkApi _billBookmarkApi;

  BillBookmarkService(this._ref, this._billBookmarkApi);

  Future<SliceResponseBookmarkedBillResponse> getBookmarkedBills({
    DateTime? fromDate,
    DateTime? toDate,
    required List<String> categoryCodes,
    required List<String> stageCodes,
    required MPSort sort,
    int page = 0,
    int size = 20,
  }) async {
    try {
      return await _billBookmarkApi.getBookmarkedBills(
        fromDate: fromDate,
        toDate: toDate,
        categoryCodes: categoryCodes,
        stageCodes: stageCodes,
        sortType: sort.value,
        page: page,
        size: size,
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
