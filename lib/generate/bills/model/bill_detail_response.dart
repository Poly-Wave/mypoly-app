//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/bills/model/bill_vote_summary_response.dart';
import 'package:mypoly/generate/bills/model/bill_category_summary_response.dart';
import 'package:mypoly/generate/bills/model/bill_stage_response.dart';
import 'package:mypoly/generate/bills/model/bill_ai_summary_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_detail_response.freezed.dart';
part 'bill_detail_response.g.dart';

@freezed
abstract class BillDetailResponse with _$BillDetailResponse {
  const factory BillDetailResponse({
    /// 의안 ID
    @JsonKey(name: r'billId') int? billId,

    /// 의안 공식 제목
    @JsonKey(name: r'officialTitle') String? officialTitle,

    /// 접수일
    @JsonKey(name: r'proposalDate') DateTime? proposalDate,

    /// 대표 제안자명
    @JsonKey(name: r'representativeProposerName')
    String? representativeProposerName,

    /// 제안자 수
    @JsonKey(name: r'proposerCount') int? proposerCount,

    /// 원문 URL
    @JsonKey(name: r'detailUrl') String? detailUrl,
    @JsonKey(name: r'stage') BillStageResponse? stage,
    @JsonKey(name: r'aiSummary') BillAiSummaryResponse? aiSummary,

    /// 카테고리 목록
    @JsonKey(name: r'categories') List<BillCategorySummaryResponse>? categories,
    @JsonKey(name: r'voteSummary') BillVoteSummaryResponse? voteSummary,
  }) = _BillDetailResponse;

  factory BillDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BillDetailResponseFromJson(json);
}
