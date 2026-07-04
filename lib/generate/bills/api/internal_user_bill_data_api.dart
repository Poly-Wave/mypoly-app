//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'internal_user_bill_data_api.g.dart';

@RestApi()
abstract class InternalUserBillDataApi {
  factory InternalUserBillDataApi(Dio dio, {String? baseUrl}) =
      _InternalUserBillDataApi;

  /// [Internal] 사용자 의안 파생 데이터 삭제(북마크/관심사/조회)
  /// 회원 탈퇴 시 해당 사용자의 북마크/관심사/조회 기록을 삭제한다. 표결(투표) 기록은 표결 결과 보존을 위해 삭제하지 않는다. 멱등하게 동작한다.
  ///
  /// Parameters:
  /// * [xInternalApiKey] - 서비스 간 internal 공유 키
  /// * [userId] - 탈퇴 사용자 ID
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @DELETE('/internal/users/{userId}/bill-data')
  Future<void> deleteUserBillData({
    @Header('xInternalApiKey') required String xInternalApiKey,
    @Path('userId') required int userId,
    CancelToken? cancelToken,
  });
}
