//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_response.freezed.dart';
part 'agenda_response.g.dart';

@freezed
abstract class AgendaResponse with _$AgendaResponse {
  const factory AgendaResponse({
    /// 의안 ID
    @JsonKey(name: r'billId') int? billId,

    /// 의안 공식 제목
    @JsonKey(name: r'officialTitle') String? officialTitle,

    /// 찬성 비율 (0~1)
    @JsonKey(name: r'agreeRatio') double? agreeRatio,

    /// 반대 비율 (0~1)
    @JsonKey(name: r'disagreeRatio') double? disagreeRatio,

    /// 총 투표 수
    @JsonKey(name: r'totalVoteCount') int? totalVoteCount,

    /// 현재 사용자의 투표 여부
    @JsonKey(name: r'hasVoted') bool? hasVoted,

    /// 메인 리스트 카테고리 이미지 URL
    @JsonKey(name: r'iconUrl') String? iconUrl,
  }) = _AgendaResponse;

  factory AgendaResponse.fromJson(Map<String, dynamic> json) =>
      _$AgendaResponseFromJson(json);
}
