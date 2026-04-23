//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_main_response.freezed.dart';
part 'agenda_main_response.g.dart';

@freezed
abstract class AgendaMainResponse with _$AgendaMainResponse {
  const factory AgendaMainResponse({
    /// 카테고리 code
    @JsonKey(name: r'categoryCode') String? categoryCode,

    /// 카테고리명
    @JsonKey(name: r'categoryName') String? categoryName,

    /// 카테고리 이미지 URL
    @JsonKey(name: r'categoryIconUrl') String? categoryIconUrl,

    /// 카테고리 배경색 (HEX)
    @JsonKey(name: r'categoryBackgroundColor') String? categoryBackgroundColor,

    /// 제목
    @JsonKey(name: r'title') String? title,

    /// 내용
    @JsonKey(name: r'content') String? content,

    /// 등록일
    @JsonKey(name: r'registeredDate') String? registeredDate,

    /// 조회 수
    @JsonKey(name: r'viewCount') int? viewCount,

    /// 투표 수
    @JsonKey(name: r'voteCount') int? voteCount,
  }) = _AgendaMainResponse;

  factory AgendaMainResponse.fromJson(Map<String, dynamic> json) =>
      _$AgendaMainResponseFromJson(json);
}
