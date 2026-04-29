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
    @JsonKey(name: r'billId') required int billId,

    /// 의안 공식 제목
    @JsonKey(name: r'officialTitle') required String officialTitle,

    /// 접수일
    @JsonKey(name: r'proposalDate') required DateTime proposalDate,

    /// 대표 제안자명
    @JsonKey(name: r'representativeProposerName')
    required String representativeProposerName,

    /// 제안자 수
    @JsonKey(name: r'proposerCount') required int proposerCount,

    /// 원문 URL
    @JsonKey(name: r'detailUrl') required String detailUrl,

    /// 조회수
    @JsonKey(name: r'viewCount') required int viewCount,

    /// 현재 사용자의 보관 여부
    @JsonKey(name: r'bookmarked') required bool bookmarked,
    @JsonKey(name: r'stage') required BillStageResponse stage,
    @JsonKey(name: r'aiSummary') required BillAiSummaryResponse aiSummary,
    @JsonKey(name: r'category') required BillCategorySummaryResponse category,
    @JsonKey(name: r'voteSummary') required BillVoteSummaryResponse voteSummary,
  }) = _BillDetailResponse;

  factory BillDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BillDetailResponseFromJson(json);
}
