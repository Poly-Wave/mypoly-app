//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/bookmarked_bill_slice_response.dart';
import 'package:mypoly/generate/bills/model/error_response.dart';

part 'bill_bookmark_api.g.dart';

@RestApi()
abstract class BillBookmarkApi {
  factory BillBookmarkApi(Dio dio, {String? baseUrl}) = _BillBookmarkApi;

  /// 보관함 안건 목록 조회
  /// 로그인 사용자가 보관한 의안 목록을 조회합니다.  - 날짜 필터는 &#39;보관한 날짜&#39; 기준입니다. - categoryCodes는 의안의 AI 카테고리 중 하나라도 매칭되면 포함됩니다. - stageCodes는 앱용 진행 단계 코드 기준입니다. 사용 가능 값: RECEIVED, REVIEW, DECISION, COMPLETED - sortType 기본값은 LATEST입니다. - 정렬은 pageable.sort가 아닌 sortType으로 제어합니다. - 사용 가능 값: LATEST, POPULAR
  ///
  /// Parameters:
  /// * [fromDate] - 보관 시작일, KST 기준. 2026-05-13 또는 2026-05-13T00:00:00.000Z 형식
  /// * [toDate] - 보관 종료일, KST 기준. 2026-05-13 또는 2026-05-13T00:00:00.000Z 형식
  /// * [categoryCodes] - 카테고리 코드 목록
  /// * [stageCodes] - 앱용 진행 단계 코드 목록
  /// * [sortType] - 정렬 방식 (LATEST: 최근 보관순, POPULAR: 인기순)
  /// * [page] - 페이지 번호, 0부터 시작
  /// * [size] - 페이지 크기
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/bookmarks')
  Future<BookmarkedBillSliceResponse> getBookmarkedBills({
    @Query('fromDate') String? fromDate,
    @Query('toDate') String? toDate,
    @Query('categoryCodes') List<String>? categoryCodes,
    @Query('stageCodes') List<String>? stageCodes,
    @Query('sortType') String? sortType = 'LATEST',
    @Query('page') int? page = 0,
    @Query('size') int? size = 20,
    CancelToken? cancelToken,
  });
}
