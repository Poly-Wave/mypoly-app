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
    @JsonKey(name: r'code') required String code,

    /// 카테고리 표시명
    @JsonKey(name: r'name') required String name,

    /// 표시 순서
    @JsonKey(name: r'displayOrder') required int displayOrder,

    /// 아이콘 URL
    @JsonKey(name: r'iconUrl') required String iconUrl,

    /// 카테고리 배경색 HEX, # 제외
    @JsonKey(name: r'backgroundColor') required String backgroundColor,

    /// 카테고리 텍스트색 HEX, # 제외
    @JsonKey(name: r'textColor') required String textColor,

    /// 카테고리 뱃지 배경색 HEX, # 제외
    @JsonKey(name: r'badgeBackgroundColor')
    required String badgeBackgroundColor,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}
