//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/users/model/address_info_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_search_response.freezed.dart';
part 'address_search_response.g.dart';

@freezed
abstract class AddressSearchResponse with _$AddressSearchResponse {
  const factory AddressSearchResponse({
    /// 전체 검색 결과 수
    @JsonKey(name: r'totalCount') required int totalCount,

    /// 현재 페이지 번호
    @JsonKey(name: r'currentPage') required int currentPage,

    /// 페이지당 출력 개수
    @JsonKey(name: r'countPerPage') required int countPerPage,

    /// 주소 목록
    @JsonKey(name: r'addresses') required List<AddressInfoResponse> addresses,
  }) = _AddressSearchResponse;

  factory AddressSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressSearchResponseFromJson(json);
}
