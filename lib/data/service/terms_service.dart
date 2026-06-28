import 'package:dio/dio.dart';
import 'package:mypoly/generate/users/api/terms_api.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:mypoly/util/error.dart';
import 'package:mypoly/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class TermsService {
  // ignore: unused_field
  final Ref _ref;
  final TermsApi _termsApi;

  TermsService(this._ref, this._termsApi);

  Future<List<TermsResponse>> getTerms() async {
    try {
      final response = await _termsApi.getLatestTerms();

      return response.terms;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<String> getTermHtml(int termId) async {
    try {
      return await _termsApi.getTermsHtml(termsId: termId);
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }
}
