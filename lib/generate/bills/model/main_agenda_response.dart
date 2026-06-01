//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_agenda_response.freezed.dart';
part 'main_agenda_response.g.dart';

@freezed
abstract class MainAgendaResponse with _$MainAgendaResponse {
  const factory MainAgendaResponse({
    /// 의안 ID
    @JsonKey(name: r'billId') required int billId,

    /// 주제 코드
    @JsonKey(name: r'categoryCode') String? categoryCode,

    /// 주제 이름
    @JsonKey(name: r'categoryName') String? categoryName,

    /// 주제 아이콘 URL
    @JsonKey(name: r'categoryIconUrl') String? categoryIconUrl,

    /// 주제 배경색(HEX, # 제외)
    @JsonKey(name: r'categoryBackgroundColor') String? categoryBackgroundColor,

    /// 주제 글자색(HEX, # 제외)
    @JsonKey(name: r'categoryTextColor') String? categoryTextColor,

    /// 제목
    @JsonKey(name: r'title') required String title,

    /// 내용 요약
    @JsonKey(name: r'content') String? content,

    /// 등록일자
    @JsonKey(name: r'registeredDate') required DateTime registeredDate,

    /// 조회수
    @JsonKey(name: r'viewCount') required int viewCount,

    /// 투표수
    @JsonKey(name: r'voteCount') required int voteCount,
  }) = _MainAgendaResponse;

  factory MainAgendaResponse.fromJson(Map<String, dynamic> json) =>
      _$MainAgendaResponseFromJson(json);
}
