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

    /// AI 요약 본문
    @JsonKey(name: r'summary') required String summary,
  }) = _BillAiSummaryResponse;

  factory BillAiSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$BillAiSummaryResponseFromJson(json);
}
