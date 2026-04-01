//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda_tab_response.freezed.dart';
part 'agenda_tab_response.g.dart';

@freezed
abstract class AgendaTabResponse with _$AgendaTabResponse {
  const factory AgendaTabResponse({
    /// 탭 코드
    @JsonKey(name: r'code') String? code,

    /// 탭 라벨
    @JsonKey(name: r'label') String? label,

    /// 탭 설명
    @JsonKey(name: r'description') String? description,

    /// 표시 순서
    @JsonKey(name: r'displayOrder') int? displayOrder,
  }) = _AgendaTabResponse;

  factory AgendaTabResponse.fromJson(Map<String, dynamic> json) =>
      _$AgendaTabResponseFromJson(json);
}
