//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'terms_response.freezed.dart';
part 'terms_response.g.dart';

@freezed
abstract class TermsResponse with _$TermsResponse {
  const factory TermsResponse({
    /// 약관 ID
    @JsonKey(name: r'id') required int id,

    /// 약관 이름(내부 식별자)
    @JsonKey(name: r'name') required String name,

    /// 표시 제목
    @JsonKey(name: r'title') required String title,

    /// 버전
    @JsonKey(name: r'version') required int version,

    /// 필수 여부
    @JsonKey(name: r'required') required bool required_,

    /// 적용 시작일
    @JsonKey(name: r'effectiveFrom') required DateTime effectiveFrom,
  }) = _TermsResponse;

  factory TermsResponse.fromJson(Map<String, dynamic> json) =>
      _$TermsResponseFromJson(json);
}
