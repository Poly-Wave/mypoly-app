//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_agenda_response.freezed.dart';
part 'search_agenda_response.g.dart';

@freezed
abstract class SearchAgendaResponse with _$SearchAgendaResponse {
  const factory SearchAgendaResponse({
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

    /// 조회수
    @JsonKey(name: r'viewCount') required int viewCount,

    /// 투표수
    @JsonKey(name: r'voteCount') required int voteCount,
  }) = _SearchAgendaResponse;

  factory SearchAgendaResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchAgendaResponseFromJson(json);
}
