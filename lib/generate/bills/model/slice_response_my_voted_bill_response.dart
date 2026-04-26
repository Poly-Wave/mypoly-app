//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/bills/model/my_voted_bill_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'slice_response_my_voted_bill_response.freezed.dart';
part 'slice_response_my_voted_bill_response.g.dart';

@freezed
abstract class SliceResponseMyVotedBillResponse
    with _$SliceResponseMyVotedBillResponse {
  const factory SliceResponseMyVotedBillResponse({
    /// 목록 데이터
    @JsonKey(name: r'content') List<MyVotedBillResponse>? content,

    /// 현재 페이지 번호
    @JsonKey(name: r'page') int? page,

    /// 페이지 크기
    @JsonKey(name: r'size') int? size,

    /// 다음 페이지 존재 여부
    @JsonKey(name: r'hasNext') bool? hasNext,
  }) = _SliceResponseMyVotedBillResponse;

  factory SliceResponseMyVotedBillResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$SliceResponseMyVotedBillResponseFromJson(json);
}
