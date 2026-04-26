//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_bookmark_status_response.freezed.dart';
part 'bill_bookmark_status_response.g.dart';

@freezed
abstract class BillBookmarkStatusResponse with _$BillBookmarkStatusResponse {
  const factory BillBookmarkStatusResponse({
    /// 의안 ID
    @JsonKey(name: r'billId') int? billId,

    /// 현재 사용자의 보관 여부
    @JsonKey(name: r'bookmarked') bool? bookmarked,
  }) = _BillBookmarkStatusResponse;

  factory BillBookmarkStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$BillBookmarkStatusResponseFromJson(json);
}
