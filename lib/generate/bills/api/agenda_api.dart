//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/agenda_response.dart';
import 'package:mypoly/generate/bills/model/agenda_tab_response.dart';
import 'package:mypoly/generate/bills/model/agenda_main_response.dart';
import 'package:mypoly/generate/bills/model/error_response.dart';
import 'package:mypoly/generate/bills/model/pageable.dart';

part 'agenda_api.g.dart';

@RestApi()
abstract class AgendaApi {
  factory AgendaApi(Dio dio, {String? baseUrl}) = _AgendaApi;

  /// 탭별 안건 목록 조회
  /// 탭 코드에 해당하는 안건 목록을 반환합니다. 로그인한 사용자만 호출 가능합니다. - HOT_DEBATE: 쟁쟁한 (찬반 비율이 팽팽한 순) - PERSONALIZED: 맞춤형 (준비 중) - TRENDING: 요즘 핫한 (최근 7일 투표 완료 수 순, 배치 선계산)
  ///
  /// Parameters:
  /// * [tabCode] - 탭 코드 (HOT_DEBATE, PERSONALIZED, TRENDING)
  /// * [pageable]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/tabs/{tabCode}')
  Future<List<AgendaResponse>> getAgendasByTab({
    @Path('tabCode') required String tabCode,
    @Query('pageable') required Pageable pageable,
    CancelToken? cancelToken,
  });

  /// 탭 목록 조회
  /// 안건 목록에 사용할 탭(쟁쟁한, 맞춤형, 요즘 핫한 등) 메타 정보를 반환합니다. 로그인한 사용자만 호출 가능합니다.
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/tabs')
  Future<List<AgendaTabResponse>> getTabs({CancelToken? cancelToken});

  /// 안건 메인 목록 조회
  /// 안건 메인 화면용 목록을 반환합니다. 로그인한 사용자만 호출 가능합니다.
  ///
  /// Parameters:
  /// * [aiRecommended] - Default value : false
  /// * [pageable] {  "page": 0,  "size": 1,  "sort": [    "string"  ]}
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/main')
  Future<List<AgendaMainResponse>> getAgendasBymain({
    @Query('aiRecommended') bool aiRecommended = false,
    @Query('pageable') required Pageable pageable,
    CancelToken? cancelToken,
  });
}
