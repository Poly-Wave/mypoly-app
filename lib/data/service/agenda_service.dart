import 'package:dio/dio.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/generate/bills/api/agenda_api.dart';
import 'package:mypoly/generate/bills/api/bill_bookmark_api.dart';
import 'package:mypoly/generate/bills/api/bill_detail_api.dart';
import 'package:mypoly/generate/bills/model/agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/agenda_tab_response.dart';
import 'package:mypoly/generate/bills/model/bill_detail_response.dart';
import 'package:mypoly/generate/bills/model/bill_vote_detail_response.dart';
import 'package:mypoly/generate/bills/model/bookmarked_bill_slice_response.dart';
import 'package:mypoly/generate/bills/model/interest_agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/main_agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/search_agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/similar_topic_bill_response.dart';
import 'package:mypoly/util/error.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AgendaService {
  // ignore: unused_field
  final Ref _ref;
  final AgendaApi _agendaApi;
  final BillBookmarkApi _billBookmarkApi;
  final BillDetailApi _billDetailApi;

  AgendaService(
    this._ref,
    this._agendaApi,
    this._billBookmarkApi,
    this._billDetailApi,
  );

  Future<SearchAgendaSliceResponse> searchAgendas({
    required String keyword,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _agendaApi.searchAgendas(
        keyword: keyword,
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

  Future<InterestAgendaSliceResponse> getInterestAgendas({
    MPSort sort = .popular,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _agendaApi.getInterestAgendas(
        sortType: sort.value,
        page: page,
        size: size,
        cancelToken: cancelToken,
      );

      return response;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<List<AgendaTabResponse>> getTabs({CancelToken? cancelToken}) async {
    try {
      return await _agendaApi.getTabs(cancelToken: cancelToken);
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<AgendaSliceResponse> getAgendasByTab({
    required String tabCode,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _agendaApi.getAgendasByTab(
        tabCode: tabCode,
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

  Future<MainAgendaSliceResponse> getMainAgendas({
    required List<String> categoryCodes,
    required MPSort sort,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _agendaApi.getMainAgendas(
        categoryCodes: categoryCodes.isNotEmpty ? categoryCodes : null,
        sortType: sort.value,
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

  Future<BookmarkedBillSliceResponse> getBookmarkedAgendas({
    DateTime? fromDate,
    DateTime? toDate,
    required List<String> categoryCodes,
    required List<String> stageCodes,
    required MPSort sort,
    int page = 0,
    int size = 20,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _billBookmarkApi.getBookmarkedBills(
        fromDate: fromDate?.toDashYMD,
        toDate: toDate?.toDashYMD,
        categoryCodes: categoryCodes.isNotEmpty ? categoryCodes : null,
        stageCodes: stageCodes,
        sortType: sort.value,
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

  Future<BillDetailResponse> getAgenda(int billId) async {
    try {
      return await _billDetailApi.getBillDetail(billId: billId);
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<BillVoteDetailResponse> getVote(int billId) async {
    try {
      return await _billDetailApi.getBillVoteDetail(billId: billId);
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<bool> updateBookmark({
    required int billId,
    required bool bookmarked,
  }) async {
    try {
      final response = bookmarked
          ? await _billDetailApi.bookmarkBill(billId: billId)
          : await _billDetailApi.unbookmarkBill(billId: billId);

      return response.bookmarked;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<List<SimilarTopicBillResponse>> getSimilarTopics({
    required int billId,
    required String sortType,
  }) async {
    try {
      return await _billDetailApi.getSimilarTopics(
        billId: billId,
        sortType: sortType,
        size: 3,
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }
}
