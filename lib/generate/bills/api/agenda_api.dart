//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/agenda_response.dart';
import 'package:mypoly/generate/bills/model/agenda_tab_response.dart';
import 'package:mypoly/generate/bills/model/error_response.dart';
import 'package:mypoly/generate/bills/model/interest_agenda_response.dart';
import 'package:mypoly/generate/bills/model/main_agenda_response.dart';
import 'package:mypoly/generate/bills/model/pageable.dart';

part 'agenda_api.g.dart';

@RestApi()
abstract class AgendaApi {
  factory AgendaApi(Dio dio, {String? baseUrl}) = _AgendaApi;

  /// 탭별 안건 목록 조회
  /// 탭 코드에 해당하는 안건 목록을 반환합니다. 로그인한 사용자만 호출 가능합니다. - HOT_DEBATE: 쟁쟁한 (찬반 비율이 팽팽한 순) - TRENDING: 요즘 핫한 (최근 7일 투표 완료 수 순, 배치 선계산) - RECENT_30D: 최근 30일 (최근 30일 이내 투표가 최소 M건 이상인 의안만, M은 쟁쟁한과 동일, 해당 기간 투표 수 많은 순) - SAME_AGE: 내 또래 (최근 7일 이내 동일 연령대 투표만 집계, 10건 미만 의안 제외. 일수·최소 투표 수는 쟁쟁한과 동일 설정)
  ///
  /// Parameters:
  /// * [tabCode] - 탭 코드 (HOT_DEBATE, TRENDING, RECENT_30D, SAME_AGE)
  /// * [pageable]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/tabs/{tabCode}')
  Future<List<AgendaResponse>> getAgendasByTab({
    @Path('tabCode') required String tabCode,
    @Query('pageable') required Pageable pageable,
    CancelToken? cancelToken,
  });

  /// 관심 주제 안건 목록 조회
  /// 관심 주제 기반 안건 목록을 반환합니다. 로그인한 사용자만 호출 가능합니다. - sort&#x3D;LATEST: 최신 등록일 기준 내림차순 (기본값) - sort&#x3D;POPULAR: 최근 7일 투표 완료 수(배치 스냅샷) 기준 내림차순 - 사용자 관심 주제와 일치하는 카테고리만 필터링됩니다. - 본 API는 조회수/투표수를 반환하지 않습니다.
  ///
  /// Parameters:
  /// * [pageable]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/interests')
  Future<List<InterestAgendaResponse>> getInterestAgendas({
    @Query('pageable') required Pageable pageable,
    CancelToken? cancelToken,
  });

  /// 안건 메인 목록 조회
  /// 안건 메인 화면용 목록을 반환합니다. 로그인한 사용자만 호출 가능합니다. - sort&#x3D;LATEST: 최신 등록일 기준 내림차순 (기본값) - sort&#x3D;POPULAR: 최근 7일 투표 완료 수(배치 스냅샷) 기준 내림차순 - categoryCodes 미지정 시: 사용자 관심 주제와 일치하는 카테고리만 상시 필터링됩니다. - categoryCodes 지정 시: 전달된 주제 코드 목록으로 필터링합니다.
  ///
  /// Parameters:
  /// * [pageable]
  /// * [categoryCodes] - 주제 코드 목록(선택). 지정 시 해당 주제들만 조회
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/main')
  Future<List<MainAgendaResponse>> getMainAgendas({
    @Query('pageable') required Pageable pageable,
    @Query('categoryCodes') List<String>? categoryCodes,
    CancelToken? cancelToken,
  });

  /// 탭 목록 조회
  /// 안건 목록에 사용할 탭(쟁쟁한, 요즘 핫한, 최근 30일, 내 또래) 메타 정보를 반환합니다. 로그인한 사용자만 호출 가능합니다.
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/tabs')
  Future<List<AgendaTabResponse>> getTabs({CancelToken? cancelToken});
}
