//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_interest_update_request.freezed.dart';
part 'category_interest_update_request.g.dart';

@freezed
abstract class CategoryInterestUpdateRequest
    with _$CategoryInterestUpdateRequest {
  const factory CategoryInterestUpdateRequest({
    /// 관심 카테고리 ID 목록. (최소 1개)  - 중복 값은 자동으로 제거됩니다. - 존재하지 않거나 비활성화된 카테고리 ID는 저장 시 무시됩니다.
    @JsonKey(name: r'categoryIds') required List<int> categoryIds,
  }) = _CategoryInterestUpdateRequest;

  factory CategoryInterestUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryInterestUpdateRequestFromJson(json);
}
