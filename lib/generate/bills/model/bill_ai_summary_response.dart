//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_ai_summary_response.freezed.dart';
part 'bill_ai_summary_response.g.dart';

@freezed
abstract class BillAiSummaryResponse with _$BillAiSummaryResponse {
  const factory BillAiSummaryResponse({
    /// AI 헤드라인
    @JsonKey(name: r'headline') required String headline,

    /// AI 3줄 요약. 각 줄이 배열 원소로 내려간다.
    @JsonKey(name: r'summaryLines') required List<String> summaryLines,
  }) = _BillAiSummaryResponse;

  factory BillAiSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$BillAiSummaryResponseFromJson(json);
}
