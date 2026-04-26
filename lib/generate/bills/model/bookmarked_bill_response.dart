//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmarked_bill_response.freezed.dart';
part 'bookmarked_bill_response.g.dart';

@freezed
abstract class BookmarkedBillResponse with _$BookmarkedBillResponse {
  const factory BookmarkedBillResponse({
    /// 의안 ID
    @JsonKey(name: r'billId') int? billId,

    /// 의안 제목
    @JsonKey(name: r'title') String? title,

    /// 의안 접수일
    @JsonKey(name: r'registeredDate') DateTime? registeredDate,

    /// 보관한 시각(KST, +09:00 오프셋 포함)
    @JsonKey(name: r'bookmarkedAt') DateTime? bookmarkedAt,

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

    /// 현재 사용자의 보관 여부
    @JsonKey(name: r'bookmarked') bool? bookmarked,
  }) = _BookmarkedBillResponse;

  factory BookmarkedBillResponse.fromJson(Map<String, dynamic> json) =>
      _$BookmarkedBillResponseFromJson(json);
}
