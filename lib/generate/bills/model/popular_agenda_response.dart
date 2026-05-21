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

    /// 제목
    @JsonKey(name: r'title') required String title,

    /// 등록일자
    @JsonKey(name: r'registeredDate') required DateTime registeredDate,

    /// 누적 조회수
    @JsonKey(name: r'viewCount') required int viewCount,

    /// 이번 주 조회 증가분 (KST 월요일 00:00 기준)
    @JsonKey(name: r'viewCountWeekly') required int viewCountWeekly,

    /// 투표수
    @JsonKey(name: r'voteCount') required int voteCount,

    /// 현재 사용자 투표 여부
    @JsonKey(name: r'hasVoted') required bool hasVoted,
  }) = _PopularAgendaResponse;

  factory PopularAgendaResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularAgendaResponseFromJson(json);
}
