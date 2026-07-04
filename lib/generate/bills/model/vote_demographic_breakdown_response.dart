//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_demographic_breakdown_response.freezed.dart';
part 'vote_demographic_breakdown_response.g.dart';

@freezed
abstract class VoteDemographicBreakdownResponse
    with _$VoteDemographicBreakdownResponse {
  const factory VoteDemographicBreakdownResponse({
    /// 구간 코드. ageBand: TEN/TWENTY/.../SIXTY_PLUS, gender: MAN/WOMAN
    @JsonKey(name: r'segment') required String segment,

    /// 해당 구간 투표 수
    @JsonKey(name: r'count') required int count,

    /// 해당 구간 비율 (0~1). 분모는 해당 구분값이 있는 투표 수 합계
    @JsonKey(name: r'ratio') required double ratio,
  }) = _VoteDemographicBreakdownResponse;

  factory VoteDemographicBreakdownResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$VoteDemographicBreakdownResponseFromJson(json);
}
