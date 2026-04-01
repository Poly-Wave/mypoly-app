//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pageable.freezed.dart';
part 'pageable.g.dart';

@freezed
abstract class Pageable with _$Pageable {
  const factory Pageable({
    // minimum: 0
    @JsonKey(name: r'page') int? page,
    // minimum: 1
    @JsonKey(name: r'size') int? size,
    @JsonKey(name: r'sort') List<String>? sort,
  }) = _Pageable;

  factory Pageable.fromJson(Map<String, dynamic> json) =>
      _$PageableFromJson(json);
}
