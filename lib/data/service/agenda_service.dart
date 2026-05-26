import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/generate/bills/api/agenda_api.dart';
import 'package:mypoly/generate/bills/model/pageable.dart';
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
        pageable: Pageable(page: page, size: size),
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
