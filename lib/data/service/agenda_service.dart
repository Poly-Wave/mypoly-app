import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/generate/bills/api/agenda_api.dart';
import 'package:mypoly/generate/bills/model/agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/agenda_tab_response.dart';
import 'package:mypoly/generate/bills/model/interest_agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/main_agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/search_agenda_slice_response.dart';
import 'package:mypoly/util/error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AgendaService {
  // ignore: unused_field
  final Ref _ref;
  final AgendaApi _agendaApi;

  AgendaService(this._ref, this._agendaApi);

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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<List<AgendaTabResponse>> getTabs({CancelToken? cancelToken}) async {
    try {
      return await _agendaApi.getTabs(cancelToken: cancelToken);
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
        categoryCodes: categoryCodes,
        sortType: sort.value,
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
