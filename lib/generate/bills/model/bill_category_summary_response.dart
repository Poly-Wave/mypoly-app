//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_category_summary_response.freezed.dart';
part 'bill_category_summary_response.g.dart';

@freezed
abstract class BillCategorySummaryResponse with _$BillCategorySummaryResponse {
  const factory BillCategorySummaryResponse({
    /// 카테고리 ID
    @JsonKey(name: r'categoryId') int? categoryId,

    /// 카테고리 코드
    @JsonKey(name: r'categoryCode') String? categoryCode,

    /// 카테고리명
    @JsonKey(name: r'categoryName') String? categoryName,

    /// 카테고리 순위
    @JsonKey(name: r'rankOrder') int? rankOrder,
  }) = _BillCategorySummaryResponse;

  factory BillCategorySummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$BillCategorySummaryResponseFromJson(json);
}
