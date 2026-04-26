//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_voted_bill_response.freezed.dart';
part 'my_voted_bill_response.g.dart';

@freezed
abstract class MyVotedBillResponse with _$MyVotedBillResponse {
  const factory MyVotedBillResponse({
    /// 의안 ID
    @JsonKey(name: r'billId') int? billId,

    /// 의안 제목
    @JsonKey(name: r'title') String? title,

    /// 의안 접수일
    @JsonKey(name: r'registeredDate') DateTime? registeredDate,

    /// 투표한 시각(KST, +09:00 오프셋 포함)
    @JsonKey(name: r'votedAt') DateTime? votedAt,

    /// 현재 사용자의 투표 결과
    @JsonKey(name: r'myVoteResult') String? myVoteResult,

    /// 앱용 진행 단계 코드
    @JsonKey(name: r'stageCode') String? stageCode,

    /// 앱용 진행 단계명
    @JsonKey(name: r'stageName') String? stageName,

    /// 앱용 진행 단계 순서
    @JsonKey(name: r'stageOrder') int? stageOrder,

    /// 대표 카테고리 코드
    @JsonKey(name: r'categoryCode') String? categoryCode,

    /// 대표 카테고리명
    @JsonKey(name: r'categoryName') String? categoryName,

    /// 대표 카테고리 배경색 HEX, # 제외
    @JsonKey(name: r'categoryBackgroundColor') String? categoryBackgroundColor,

    /// 조회수
    @JsonKey(name: r'viewCount') int? viewCount,

    /// 투표수
    @JsonKey(name: r'voteCount') int? voteCount,
  }) = _MyVotedBillResponse;

  factory MyVotedBillResponse.fromJson(Map<String, dynamic> json) =>
      _$MyVotedBillResponseFromJson(json);
}
