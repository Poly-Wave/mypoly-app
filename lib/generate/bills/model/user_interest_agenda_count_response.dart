//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_interest_agenda_count_response.freezed.dart';
part 'user_interest_agenda_count_response.g.dart';

@freezed
abstract class UserInterestAgendaCountResponse
    with _$UserInterestAgendaCountResponse {
  const factory UserInterestAgendaCountResponse({
    /// 사용자 ID
    @JsonKey(name: r'userId') required int userId,

    /// [start, end) 범위에 first_collected_at 이 들어간 관심 매칭 안건 개수
    @JsonKey(name: r'count') required int count,
  }) = _UserInterestAgendaCountResponse;

  factory UserInterestAgendaCountResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInterestAgendaCountResponseFromJson(json);
}
