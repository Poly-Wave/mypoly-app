//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/agenda_tab_response.dart';
import 'package:mypoly/generate/bills/model/error_response.dart';
import 'package:mypoly/generate/bills/model/interest_agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/main_agenda_slice_response.dart';
import 'package:mypoly/generate/bills/model/popular_agenda_response.dart';
import 'package:mypoly/generate/bills/model/search_agenda_slice_response.dart';

part 'agenda_api.g.dart';

@RestApi()
abstract class AgendaApi {
  factory AgendaApi(Dio dio, {String? baseUrl}) = _AgendaApi;

  /// 탭별 안건 목록 조회
  /// 탭 코드에 해당하는 안건 목록을 반환합니다. 로그인한 사용자만 호출 가능합니다. - HOT_DEBATE: 쟁쟁한 (찬반 비율이 팽팽한 순) - TRENDING: 요즘 핫한 (최근 7일 투표 완료 수 순, 배치 선계산) - RECENT_30D: 최근 30일 (최근 30일 이내 투표가 최소 M건 이상인 의안만, M은 쟁쟁한과 동일, 해당 기간 투표 수 많은 순) - SAME_AGE: 내 또래 (최근 7일 이내 동일 연령대 투표만 집계, 10건 미만 의안 제외. 일수·최소 투표 수는 쟁쟁한과 동일 설정)
  ///
  /// Parameters:
  /// * [tabCode] - 탭 코드 (HOT_DEBATE, TRENDING, RECENT_30D, SAME_AGE)
  /// * [page] - 페이지 번호, 0부터 시작
  /// * [size] - 페이지 크기
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/tabs/{tabCode}')
  Future<AgendaSliceResponse> getAgendasByTab({
    @Path('tabCode') required String tabCode,
    @Query('page') int? page = 0,
    @Query('size') int? size = 20,
    CancelToken? cancelToken,
  });

  /// 관심 주제 안건 목록 조회
  /// 관심 주제 기반 안건 목록을 반환합니다. 로그인한 사용자만 호출 가능합니다. - sortType&#x3D;LATEST: 최신 등록일 기준 내림차순 (기본값) - sortType&#x3D;POPULAR: 최근 7일 투표 완료 수(배치 스냅샷) 기준 내림차순 - 사용자 관심 주제와 일치하는 카테고리만 필터링됩니다. - 본 API는 조회수/투표수를 반환하지 않습니다.
  ///
  /// Parameters:
  /// * [sortType] - 정렬 방식 (LATEST: 최신 등록일순, POPULAR: 최근 7일 투표순)
  /// * [page] - 페이지 번호, 0부터 시작
  /// * [size] - 페이지 크기
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/interests')
  Future<InterestAgendaSliceResponse> getInterestAgendas({
    @Query('sortType') String? sortType = 'LATEST',
    @Query('page') int? page = 0,
    @Query('size') int? size = 20,
    CancelToken? cancelToken,
  });

  /// 안건 메인 목록 조회
  /// 안건 메인 화면용 목록을 반환합니다. 로그인한 사용자만 호출 가능합니다. - sortType&#x3D;LATEST: 최신 등록일 기준 내림차순 (기본값) - sortType&#x3D;POPULAR: 최근 7일 투표 완료 수(배치 스냅샷) 기준 내림차순 - categoryCodes 미지정 시: 사용자 관심 주제와 일치하는 카테고리만 상시 필터링됩니다. - categoryCodes 지정 시: 전달된 주제 코드 목록으로 필터링합니다.
  ///
  /// Parameters:
  /// * [categoryCodes] - 주제 코드 목록(선택). 지정 시 해당 주제들만 조회
  /// * [sortType] - 정렬 방식 (LATEST: 최신 등록일순, POPULAR: 최근 7일 투표순)
  /// * [page] - 페이지 번호, 0부터 시작
  /// * [size] - 페이지 크기
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/main')
  Future<MainAgendaSliceResponse> getMainAgendas({
    @Query('categoryCodes') List<String>? categoryCodes,
    @Query('sortType') String? sortType = 'LATEST',
    @Query('page') int? page = 0,
    @Query('size') int? size = 20,
    CancelToken? cancelToken,
  });

  /// 인기 안건 조회
  /// KST 월요일 00:00 기준 이번 주 조회 증가분 Top 5를 반환합니다. 로그인한 사용자만 호출 가능합니다. - TRENDING 탭(7일 투표 수)과 달리 **조회수** 기준이며, **주간(월~일)** 구간입니다. - 약 10분 주기 배치로 선계산된 &#x60;bill_popular_view_ranking&#x60; 스냅샷을 조회합니다. - 카테고리 필터 없이 전체 의안 대상입니다. - &#x60;previousRank&#x60;: 직전 배치 실행 시점의 순위 (없으면 null) - &#x60;rankChangeSteps&#x60;: 직전 배치 대비 순위 변동 단계 수 (상승&#x3D;양수, 하락&#x3D;음수, 유지/신규&#x3D;0) - &#x60;rankChangeType&#x60;: 순위 변동 유형 (UP, DOWN, SAME, NEW)
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/popular')
  Future<List<PopularAgendaResponse>> getPopularAgendas({
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

  /// 의안 제목 검색
  /// 입력한 키워드가 의안 제목에 포함된 안건 목록을 반환합니다. 최신 등록일(proposalDate) 기준 내림차순으로 정렬됩니다.
  ///
  /// Parameters:
  /// * [keyword] - 검색 키워드
  /// * [page] - 페이지 번호, 0부터 시작
  /// * [size] - 페이지 크기
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/agendas/search')
  Future<SearchAgendaSliceResponse> searchAgendas({
    @Query('keyword') required String keyword,
    @Query('page') int? page = 0,
    @Query('size') int? size = 20,
    CancelToken? cancelToken,
  });
}
