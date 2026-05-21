//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/users/model/user_nickname_response.dart';

part 'internal_user_lookup_api.g.dart';

@RestApi()
abstract class InternalUserLookupApi {
  factory InternalUserLookupApi(Dio dio, {String? baseUrl}) =
      _InternalUserLookupApi;

  /// [Internal] 사용자 닉네임 일괄 조회
  /// 주어진 userId 목록의 닉네임을 일괄 반환한다. 존재하지 않는 id 는 응답에서 제외된다. 알림 본문 {별명} 변수 치환 등에 사용한다.
  ///
  /// Parameters:
  /// * [xInternalApiKey] - 서비스 간 internal 공유 키
  /// * [ids] - 조회할 사용자 ID 목록 (콤마 구분)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/internal/lookup/by-ids')
  Future<List<UserNicknameResponse>> getNicknamesByIds({
    @Header('xInternalApiKey') required String xInternalApiKey,
    @Query('ids') required List<int> ids,
    CancelToken? cancelToken,
  });
}
