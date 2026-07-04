//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/error_response.dart';
import 'package:mypoly/generate/bills/model/similar_member_response.dart';

part 'similar_member_api.g.dart';

@RestApi()
abstract class SimilarMemberApi {
  factory SimilarMemberApi(Dio dio, {String? baseUrl}) = _SimilarMemberApi;

  /// 유사 성향 국회의원 조회
  /// 로그인 사용자의 의안 투표 결과와 국회의원 본회의 표결 기록을 같은 의안 기준으로 비교해, 입장(찬성/반대)이 일치한 비율이 높은 순으로 국회의원을 반환합니다.  - 매칭 규칙: 사용자 AGREE ↔ 의원 찬성, 사용자 DISAGREE ↔ 의원 반대. 기권/불참 표결은 비교에서 제외합니다. - 함께 표결한 의안이 10건 이상인 국회의원만 대상으로 합니다. - 비교 가능한 데이터(사용자 투표 ∩ 의원 본회의 표결)가 없으면 빈 배열을 반환합니다.
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/members/similar')
  Future<List<SimilarMemberResponse>> getSimilarMembers({
    CancelToken? cancelToken,
  });
}
