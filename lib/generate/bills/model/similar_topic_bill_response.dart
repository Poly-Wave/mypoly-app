//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'similar_topic_bill_response.freezed.dart';
part 'similar_topic_bill_response.g.dart';

@freezed
abstract class SimilarTopicBillResponse with _$SimilarTopicBillResponse {
  const factory SimilarTopicBillResponse({
    /// 의안 ID
    @JsonKey(name: r'billId') int? billId,

    /// 의안 제목
    @JsonKey(name: r'officialTitle') String? officialTitle,

    /// 접수일
    @JsonKey(name: r'proposalDate') DateTime? proposalDate,

    /// AI 헤드라인
    @JsonKey(name: r'headline') String? headline,

    /// AI 요약
    @JsonKey(name: r'summary') String? summary,

    /// AI 3줄 요약. 각 줄이 배열 원소로 내려간다.
    @JsonKey(name: r'summaryLines') List<String>? summaryLines,

    /// 원문 URL
    @JsonKey(name: r'detailUrl') String? detailUrl,

    /// 카테고리 ID
    @JsonKey(name: r'categoryId') int? categoryId,

    /// 카테고리 코드
    @JsonKey(name: r'categoryCode') String? categoryCode,

    /// 카테고리명
    @JsonKey(name: r'categoryName') String? categoryName,
  }) = _SimilarTopicBillResponse;

  factory SimilarTopicBillResponse.fromJson(Map<String, dynamic> json) =>
      _$SimilarTopicBillResponseFromJson(json);
}
