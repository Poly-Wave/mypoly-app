//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/bills/model/main_agenda_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_agenda_slice_response.freezed.dart';
part 'main_agenda_slice_response.g.dart';

@freezed
abstract class MainAgendaSliceResponse with _$MainAgendaSliceResponse {
  const factory MainAgendaSliceResponse({
    /// 안건 메인 목록
    @JsonKey(name: r'content') required List<MainAgendaResponse> content,

    /// 현재 페이지 번호
    @JsonKey(name: r'page') required int page,

    /// 페이지 크기
    @JsonKey(name: r'size') required int size,

    /// 다음 페이지 존재 여부
    @JsonKey(name: r'hasNext') required bool hasNext,
  }) = _MainAgendaSliceResponse;

  factory MainAgendaSliceResponse.fromJson(Map<String, dynamic> json) =>
      _$MainAgendaSliceResponseFromJson(json);
}
