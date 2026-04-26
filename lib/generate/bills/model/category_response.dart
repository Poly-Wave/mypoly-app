//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_response.freezed.dart';
part 'category_response.g.dart';

@freezed
abstract class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    /// 카테고리 코드(고유)
    @JsonKey(name: r'code') String? code,

    /// 카테고리 표시명
    @JsonKey(name: r'name') String? name,

    /// 표시 순서
    @JsonKey(name: r'displayOrder') int? displayOrder,

    /// 아이콘 URL
    @JsonKey(name: r'iconUrl') String? iconUrl,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}
