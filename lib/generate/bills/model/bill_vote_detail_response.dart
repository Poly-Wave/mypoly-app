//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/bills/model/vote_demographic_breakdown_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_vote_detail_response.freezed.dart';
part 'bill_vote_detail_response.g.dart';

@freezed
abstract class BillVoteDetailResponse with _$BillVoteDetailResponse {
  const factory BillVoteDetailResponse({
    /// 찬성 수
    @JsonKey(name: r'agreeCount') required int agreeCount,

    /// 반대 수
    @JsonKey(name: r'disagreeCount') required int disagreeCount,

    /// 총 투표 수
    @JsonKey(name: r'totalVoteCount') required int totalVoteCount,

    /// 찬성 비율 (0~1)
    @JsonKey(name: r'agreeRatio') required double agreeRatio,

    /// 반대 비율 (0~1)
    @JsonKey(name: r'disagreeRatio') required double disagreeRatio,

    /// 연령대별 투표 참여 비율
    @JsonKey(name: r'ageBandBreakdown')
    required List<VoteDemographicBreakdownResponse> ageBandBreakdown,

    /// 성별 투표 참여 비율
    @JsonKey(name: r'genderBreakdown')
    required List<VoteDemographicBreakdownResponse> genderBreakdown,
  }) = _BillVoteDetailResponse;

  factory BillVoteDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BillVoteDetailResponseFromJson(json);
}
