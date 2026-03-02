//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'terms_list_response.freezed.dart';
part 'terms_list_response.g.dart';

@freezed
abstract class TermsListResponse with _$TermsListResponse {
  const factory TermsListResponse({
    /// 약관 목록
    @JsonKey(name: r'terms') required List<TermsResponse> terms,
  }) = _TermsListResponse;

  factory TermsListResponse.fromJson(Map<String, dynamic> json) =>
      _$TermsListResponseFromJson(json);
}
