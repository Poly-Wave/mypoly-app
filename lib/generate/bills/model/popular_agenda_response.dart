//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_agenda_response.freezed.dart';
part 'popular_agenda_response.g.dart';

@freezed
abstract class PopularAgendaResponse with _$PopularAgendaResponse {
  const factory PopularAgendaResponse({
    /// 순위 (1~5)
    @JsonKey(name: r'rank') required int rank,

    /// 의안 ID
    @JsonKey(name: r'billId') required int billId,

    /// 주제 코드
    @JsonKey(name: r'categoryCode') required String categoryCode,

    /// 주제 이름
    @JsonKey(name: r'categoryName') required String categoryName,

    /// 주제 텍스트색(HEX, # 제외)
    @JsonKey(name: r'categoryTextColor') required String categoryTextColor,

    /// 제목
    @JsonKey(name: r'title') required String title,

    /// AI 헤드라인
    @JsonKey(name: r'headline') required String headline,

    /// 등록일자
    @JsonKey(name: r'registeredDate') required DateTime registeredDate,

    /// 누적 조회수
    @JsonKey(name: r'viewCount') required int viewCount,

    /// 이번 주 조회 증가분 (KST 월요일 00:00 기준)
    @JsonKey(name: r'viewCountWeekly') required int viewCountWeekly,

    /// 이전 배치 기준 순위. 이전 배치 데이터가 없으면 null
    @JsonKey(name: r'previousRank') int? previousRank,

    /// 이전 배치 대비 순위 변동 단계 수(상승: 양수, 하락: 음수, 유지/신규: 0)
    @JsonKey(name: r'rankChangeSteps') required int rankChangeSteps,

    /// 순위 변동 유형
    @JsonKey(name: r'rankChangeType')
    required PopularAgendaResponseRankChangeTypeEnum rankChangeType,

    /// 투표수
    @JsonKey(name: r'voteCount') required int voteCount,

    /// 현재 사용자 투표 여부
    @JsonKey(name: r'hasVoted') required bool hasVoted,
  }) = _PopularAgendaResponse;

  factory PopularAgendaResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularAgendaResponseFromJson(json);
}

/// 순위 변동 유형
enum PopularAgendaResponseRankChangeTypeEnum {
  /// 순위 변동 유형
  @JsonValue(r'UP')
  up(r'UP'),

  /// 순위 변동 유형
  @JsonValue(r'DOWN')
  down(r'DOWN'),

  /// 순위 변동 유형
  @JsonValue(r'SAME')
  same(r'SAME'),

  /// 순위 변동 유형
  @JsonValue(r'NEW')
  new_(r'NEW');

  const PopularAgendaResponseRankChangeTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
