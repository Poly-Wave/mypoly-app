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
    @JsonKey(name: r'billId') required int billId,

    /// 의안 제목
    @JsonKey(name: r'title') required String title,

    /// AI 헤드라인
    @JsonKey(name: r'headline') required String headline,

    /// 의안 접수일
    @JsonKey(name: r'registeredDate') required DateTime registeredDate,

    /// 투표한 시각(KST, +09:00 오프셋 포함)
    @JsonKey(name: r'votedAt') required DateTime votedAt,

    /// 현재 사용자의 투표 결과
    @JsonKey(name: r'myVoteResult')
    required MyVotedBillResponseMyVoteResultEnum myVoteResult,

    /// 앱용 진행 단계 코드
    @JsonKey(name: r'stageCode') required String stageCode,

    /// 앱용 진행 단계명
    @JsonKey(name: r'stageName') required String stageName,

    /// 앱용 진행 단계 순서
    @JsonKey(name: r'stageOrder') required int stageOrder,

    /// 대표 카테고리 코드
    @JsonKey(name: r'categoryCode') required String categoryCode,

    /// 대표 카테고리명
    @JsonKey(name: r'categoryName') required String categoryName,

    /// 대표 카테고리 배경색 HEX, # 제외
    @JsonKey(name: r'categoryBackgroundColor')
    required String categoryBackgroundColor,

    /// 조회수
    @JsonKey(name: r'viewCount') required int viewCount,

    /// 투표수
    @JsonKey(name: r'voteCount') required int voteCount,
  }) = _MyVotedBillResponse;

  factory MyVotedBillResponse.fromJson(Map<String, dynamic> json) =>
      _$MyVotedBillResponseFromJson(json);
}

/// 현재 사용자의 투표 결과
enum MyVotedBillResponseMyVoteResultEnum {
  /// 현재 사용자의 투표 결과
  @JsonValue(r'AGREE')
  agree(r'AGREE'),

  /// 현재 사용자의 투표 결과
  @JsonValue(r'DISAGREE')
  disagree(r'DISAGREE');

  const MyVotedBillResponseMyVoteResultEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
