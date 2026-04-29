//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_status_history_response.freezed.dart';
part 'bill_status_history_response.g.dart';

@freezed
abstract class BillStatusHistoryResponse with _$BillStatusHistoryResponse {
  const factory BillStatusHistoryResponse({
    /// 처리일
    @JsonKey(name: r'procDate') required DateTime procDate,

    /// 원천 단계 코드
    @JsonKey(name: r'rawStageCode') required String rawStageCode,

    /// 원천 단계명
    @JsonKey(name: r'rawStageName') required String rawStageName,

    /// 앱용 단계 코드
    @JsonKey(name: r'uiStepCode') required String uiStepCode,

    /// 앱용 단계명
    @JsonKey(name: r'uiStepName') required String uiStepName,

    /// 앱용 단계 순서
    @JsonKey(name: r'uiStepOrder') required int uiStepOrder,

    /// 통과 구분
    @JsonKey(name: r'passGubn') required String passGubn,

    /// 처리 결과
    @JsonKey(name: r'generalResult') required String generalResult,
  }) = _BillStatusHistoryResponse;

  factory BillStatusHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$BillStatusHistoryResponseFromJson(json);
}
