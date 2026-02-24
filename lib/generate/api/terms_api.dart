//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//


import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'terms_api.g.dart';

@RestApi()
abstract class TermsApi {
  factory TermsApi(Dio dio, {String? baseUrl}) = _TermsApi;


  /// 최신 버전 약관 목록 조회
  /// 최신 버전 기준으로 약관 메타데이터 목록을 조회합니다.  - 본문(content)은 포함하지 않습니다. - 본문이 필요하면 &#x60;GET /terms/{termsId}/html&#x60;을 사용하세요. 
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/terms')
  Future<void> getLatestTerms({ 
    CancelToken? cancelToken,
  });


  /// 약관 본문(HTML) 조회
  /// 약관의 본문을 **HTML(text/html)** 로 반환합니다.  - WebView/브라우저 표시 용도 - 응답은 JSON(ApiResponse)이 아니라 순수 HTML 문자열입니다. 
  ///
  /// Parameters:
  /// * [termsId] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/terms/{termsId}/html')
  Future<void> getTermsHtml({ 
    @Path('termsId') required int termsId,
    CancelToken? cancelToken,
  });


  /// 약관 메타데이터 단건 조회
  /// 약관 ID로 약관의 메타데이터를 조회합니다.  - 본문(content)은 포함하지 않습니다. - 본문이 필요하면 &#x60;GET /terms/{termsId}/html&#x60;을 사용하세요. 
  ///
  /// Parameters:
  /// * [termsId] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/terms/{termsId}')
  Future<void> getTermsMeta({ 
    @Path('termsId') required int termsId,
    CancelToken? cancelToken,
  });

}

