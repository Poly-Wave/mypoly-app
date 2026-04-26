//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_member_representative_bill_response.freezed.dart';
part 'bill_member_representative_bill_response.g.dart';

@freezed
abstract class BillMemberRepresentativeBillResponse
    with _$BillMemberRepresentativeBillResponse {
  const factory BillMemberRepresentativeBillResponse({
    /// 의안 ID
    @JsonKey(name: r'billId') int? billId,

    /// 의안 제목
    @JsonKey(name: r'title') String? title,

    /// 의안 발의일
    @JsonKey(name: r'proposedDate') DateTime? proposedDate,

    /// 앱용 진행 단계 코드
    @JsonKey(name: r'stageCode') String? stageCode,

    /// 앱용 진행 단계명
    @JsonKey(name: r'stageName') String? stageName,

    /// 앱용 진행 단계 순서
    @JsonKey(name: r'stageOrder') int? stageOrder,

    /// 대표 카테고리 코드
    @JsonKey(name: r'categoryCode') String? categoryCode,

    /// 대표 카테고리명
    @JsonKey(name: r'categoryName') String? categoryName,

    /// 대표 카테고리 배경색 HEX, # 제외
    @JsonKey(name: r'categoryBackgroundColor') String? categoryBackgroundColor,

    /// 조회수
    @JsonKey(name: r'viewCount') int? viewCount,

    /// 투표수
    @JsonKey(name: r'voteCount') int? voteCount,
  }) = _BillMemberRepresentativeBillResponse;

  factory BillMemberRepresentativeBillResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$BillMemberRepresentativeBillResponseFromJson(json);
}
