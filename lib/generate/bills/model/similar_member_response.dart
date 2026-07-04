//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'similar_member_response.freezed.dart';
part 'similar_member_response.g.dart';

@freezed
abstract class SimilarMemberResponse with _$SimilarMemberResponse {
  const factory SimilarMemberResponse({
    /// 국회의원 ID
    @JsonKey(name: r'memberId') int? memberId,

    /// 이름
    @JsonKey(name: r'name') String? name,

    /// 정당명
    @JsonKey(name: r'partyName') String? partyName,

    /// 지역구명
    @JsonKey(name: r'districtName') String? districtName,

    /// 의원 사진 URL
    @JsonKey(name: r'photoUrl') String? photoUrl,

    /// 함께 표결한(비교 대상) 의안 수
    @JsonKey(name: r'comparedVoteCount') int? comparedVoteCount,

    /// 입장이 일치한 의안 수
    @JsonKey(name: r'matchedVoteCount') int? matchedVoteCount,

    /// 유사도. 입장 일치 비율(0.0~1.0), 소수점 3자리
    @JsonKey(name: r'matchRate') double? matchRate,
  }) = _SimilarMemberResponse;

  factory SimilarMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$SimilarMemberResponseFromJson(json);
}
