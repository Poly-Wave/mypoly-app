//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/bills/model/bookmarked_bill_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmarked_bill_slice_response.freezed.dart';
part 'bookmarked_bill_slice_response.g.dart';

@freezed
abstract class BookmarkedBillSliceResponse with _$BookmarkedBillSliceResponse {
  const factory BookmarkedBillSliceResponse({
    /// 보관함 안건 목록
    @JsonKey(name: r'content') required List<BookmarkedBillResponse> content,

    /// 현재 페이지 번호
    @JsonKey(name: r'page') required int page,

    /// 페이지 크기
    @JsonKey(name: r'size') required int size,

    /// 다음 페이지 존재 여부
    @JsonKey(name: r'hasNext') required bool hasNext,
  }) = _BookmarkedBillSliceResponse;

  factory BookmarkedBillSliceResponse.fromJson(Map<String, dynamic> json) =>
      _$BookmarkedBillSliceResponseFromJson(json);
}
