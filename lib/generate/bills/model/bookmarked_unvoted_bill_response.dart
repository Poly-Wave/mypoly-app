//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmarked_unvoted_bill_response.freezed.dart';
part 'bookmarked_unvoted_bill_response.g.dart';

@freezed
abstract class BookmarkedUnvotedBillResponse
    with _$BookmarkedUnvotedBillResponse {
  const factory BookmarkedUnvotedBillResponse({
    /// 사용자 ID
    @JsonKey(name: r'userId') required int userId,

    /// 의안 ID
    @JsonKey(name: r'billId') required int billId,

    /// 의안 제목
    @JsonKey(name: r'billTitle') required String billTitle,
  }) = _BookmarkedUnvotedBillResponse;

  factory BookmarkedUnvotedBillResponse.fromJson(Map<String, dynamic> json) =>
      _$BookmarkedUnvotedBillResponseFromJson(json);
}
