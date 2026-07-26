//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'co_proposer_response.freezed.dart';
part 'co_proposer_response.g.dart';

@freezed
abstract class CoProposerResponse with _$CoProposerResponse {
  const factory CoProposerResponse({
    /// 국회의원 ID. 매칭되지 않은 경우 null
    @JsonKey(name: r'memberId') int? memberId,

    /// 이름
    @JsonKey(name: r'name') required String name,

    /// 정당. 매칭되지 않은 경우 null
    @JsonKey(name: r'partyName') String? partyName,

    /// 프로필 사진 URL. 매칭되지 않은 경우 null
    @JsonKey(name: r'photoUrl') String? photoUrl,
  }) = _CoProposerResponse;

  factory CoProposerResponse.fromJson(Map<String, dynamic> json) =>
      _$CoProposerResponseFromJson(json);
}
