//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_vote_summary_response.freezed.dart';
part 'bill_vote_summary_response.g.dart';

@freezed
abstract class BillVoteSummaryResponse with _$BillVoteSummaryResponse {
  const factory BillVoteSummaryResponse({
    /// 현재 사용자의 투표 여부
    @JsonKey(name: r'hasVoted') required bool hasVoted,

    /// 현재 사용자의 투표값. hasVoted=false인 경우 아직 투표하지 않은 상태이므로 null입니다. 가능한 값: AGREE, DISAGREE
    @JsonKey(name: r'myVoteResult') required String? myVoteResult,

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
  }) = _BillVoteSummaryResponse;

  factory BillVoteSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$BillVoteSummaryResponseFromJson(json);
}
