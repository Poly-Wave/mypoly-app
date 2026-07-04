import 'package:dio/dio.dart';
import 'package:mypoly/generate/bills/api/bill_member_api.dart';
import 'package:mypoly/generate/bills/api/similar_member_api.dart';
import 'package:mypoly/generate/bills/model/similar_member_response.dart';
import 'package:mypoly/util/error.dart';
import 'package:mypoly/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class MemberService {
  // ignore: unused_field
  final Ref _ref;
  // ignore: unused_field
  final BillMemberApi _billMemberApi;
  final SimilarMemberApi _similarMemberApi;

  MemberService(this._ref, this._billMemberApi, this._similarMemberApi);

  Future<List<SimilarMemberResponse>> getSimilarMembers({
    CancelToken? cancelToken,
  }) async {
    try {
      return await _similarMemberApi.getSimilarMembers(
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }
}
