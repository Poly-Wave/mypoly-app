//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/bills/model/category_interest_update_request.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/bills/model/error_response.dart';

part 'category_api.g.dart';

@RestApi()
abstract class CategoryApi {
  factory CategoryApi(Dio dio, {String? baseUrl}) = _CategoryApi;

  /// 카테고리 목록 조회
  /// 현재 **활성화(is_active&#x3D;true)** 된 카테고리 목록을 반환합니다.  - 반환 순서: &#x60;displayOrder&#x60; 오름차순 - 인증: 불필요(공개 API)
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/categories')
  Future<List<CategoryResponse>> getCategories({CancelToken? cancelToken});

  /// 내 관심 카테고리 저장(갱신)
  /// 로그인 사용자의 관심 카테고리 목록을 저장합니다. (JWT 인증 필요)  동작 규칙 - 요청으로 받은 &#x60;categoryIds&#x60;를 기준으로 **사용자의 관심 카테고리를 갱신**합니다.   - 기존 관심사 중 요청에 없는 항목은 삭제   - 요청에 새로 추가된 항목은 추가 - **중복 ID는 자동으로 제거**됩니다. - **존재하지 않거나 비활성화된 카테고리 ID는 무시**됩니다. (에러로 실패시키지 않음)  인증 - Swagger 우측 상단 Authorize에 &#x60;Bearer {jwt}&#x60; 입력 후 호출하세요.
  ///
  /// Parameters:
  /// * [categoryInterestUpdateRequest] - 저장할 관심 카테고리 ID 목록
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/categories/interests')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> updateInterests({
    @Body()
    required CategoryInterestUpdateRequest categoryInterestUpdateRequest,
    CancelToken? cancelToken,
  });

  /// 내 관심 카테고리 저장 (온보딩 전용)
  /// 사용자 **온보딩 과정에서** 관심 카테고리 목록을 저장합니다. (JWT 인증 필요) - 온보딩 상태가 SIGNUP 또는 ONBOARDING일 때만 변경 가능합니다. - 성공 시 사용자 온보딩 상태를 CATEGORY로 업데이트합니다. - 저장 로직은 일반 관심사 저장과 동일합니다.
  ///
  /// Parameters:
  /// * [categoryInterestUpdateRequest] - 저장할 관심 카테고리 ID 목록
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @POST('/categories/onboarding/interests')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> updateOnboardingInterests({
    @Body()
    required CategoryInterestUpdateRequest categoryInterestUpdateRequest,
    CancelToken? cancelToken,
  });
}
