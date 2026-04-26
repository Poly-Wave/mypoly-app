//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/bills/model/bill_member_representative_bill_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_member_detail_response.freezed.dart';
part 'bill_member_detail_response.g.dart';

@freezed
abstract class BillMemberDetailResponse with _$BillMemberDetailResponse {
  const factory BillMemberDetailResponse({
    /// 국회의원 ID
    @JsonKey(name: r'memberId') int? memberId,

    /// 외부 의원 식별자
    @JsonKey(name: r'externalMemberId') String? externalMemberId,

    /// 국회 MONA 코드
    @JsonKey(name: r'monaCd') String? monaCd,

    /// 국회의원 번호
    @JsonKey(name: r'memberNo') String? memberNo,

    /// 이름
    @JsonKey(name: r'name') String? name,

    /// 한자 이름
    @JsonKey(name: r'nameChinese') String? nameChinese,

    /// 영문 이름
    @JsonKey(name: r'nameEnglish') String? nameEnglish,

    /// 정당명
    @JsonKey(name: r'partyName') String? partyName,

    /// 지역구명
    @JsonKey(name: r'districtName') String? districtName,

    /// 지역구 유형
    @JsonKey(name: r'districtType') String? districtType,

    /// 소속 위원회
    @JsonKey(name: r'committeeName') String? committeeName,

    /// 현재 소속 위원회
    @JsonKey(name: r'currentCommitteeName') String? currentCommitteeName,

    /// 국회 대수
    @JsonKey(name: r'era') String? era,

    /// 당선 유형
    @JsonKey(name: r'electionType') String? electionType,

    /// 성별
    @JsonKey(name: r'gender') String? gender,

    /// 생년월일
    @JsonKey(name: r'birthDate') DateTime? birthDate,

    /// 의원 사진 URL
    @JsonKey(name: r'photoUrl') String? photoUrl,

    /// 홈페이지 URL
    @JsonKey(name: r'homepageUrl') String? homepageUrl,

    /// 약력
    @JsonKey(name: r'briefHistory') String? briefHistory,

    /// 의원실 전화번호
    @JsonKey(name: r'phoneNumber') String? phoneNumber,

    /// 의원회관 사무실 호실
    @JsonKey(name: r'officeRoomNumber') String? officeRoomNumber,

    /// 이메일
    @JsonKey(name: r'email') String? email,

    /// 보좌관 목록
    @JsonKey(name: r'aides') List<String>? aides,

    /// 선임비서관 목록
    @JsonKey(name: r'chiefSecretaries') List<String>? chiefSecretaries,

    /// 비서관 목록
    @JsonKey(name: r'secretaries') List<String>? secretaries,

    /// 최근 대표 발의 의안 목록
    @JsonKey(name: r'representativeBills')
    List<BillMemberRepresentativeBillResponse>? representativeBills,
  }) = _BillMemberDetailResponse;

  factory BillMemberDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BillMemberDetailResponseFromJson(json);
}
