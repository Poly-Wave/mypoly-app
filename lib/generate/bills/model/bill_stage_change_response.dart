//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_stage_change_response.freezed.dart';
part 'bill_stage_change_response.g.dart';

@freezed
abstract class BillStageChangeResponse with _$BillStageChangeResponse {
  const factory BillStageChangeResponse({
    /// 사용자 ID
    @JsonKey(name: r'userId') required int userId,

    /// 의안 ID
    @JsonKey(name: r'billId') required int billId,

    /// 의안 제목
    @JsonKey(name: r'billTitle') required String billTitle,

    /// 이전 단계 코드(최초 단계면 null)
    @JsonKey(name: r'fromStageCode') String? fromStageCode,

    /// 이전 단계명(최초 단계면 null)
    @JsonKey(name: r'fromStageName') String? fromStageName,

    /// 현재 단계 코드
    @JsonKey(name: r'toStageCode') required String toStageCode,

    /// 현재 단계명
    @JsonKey(name: r'toStageName') required String toStageName,
  }) = _BillStageChangeResponse;

  factory BillStageChangeResponse.fromJson(Map<String, dynamic> json) =>
      _$BillStageChangeResponseFromJson(json);
}
