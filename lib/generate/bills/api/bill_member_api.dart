//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/bill_member_detail_response.dart';
import 'package:mypoly/generate/bills/model/error_response.dart';

part 'bill_member_api.g.dart';

@RestApi()
abstract class BillMemberApi {
  factory BillMemberApi(Dio dio, {String? baseUrl}) = _BillMemberApi;

  /// 국회의원 상세 조회
  /// 국회의원 상세 화면에 필요한 기본 프로필 정보, 의원실 연락처, 보좌진 정보, 최근 대표 발의 의안 목록을 반환합니다. 관심 분야 통계와 사용자 관심사 일치도는 후속 API 확장에서 같은 응답에 추가할 예정입니다.
  ///
  /// Parameters:
  /// * [memberId] - 국회의원 ID
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/members/{memberId}')
  Future<BillMemberDetailResponse> getMemberDetail({
    @Path('memberId') required int memberId,
    CancelToken? cancelToken,
  });
}
