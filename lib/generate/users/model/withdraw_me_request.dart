//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdraw_me_request.freezed.dart';
part 'withdraw_me_request.g.dart';

@freezed
abstract class WithdrawMeRequest with _$WithdrawMeRequest {
  const factory WithdrawMeRequest({
    /// 탈퇴 사유 (최소 1개)
    @JsonKey(name: r'reasons') required List<String> reasons,

    /// 기타 사유
    @JsonKey(name: r'etcText') required String etcText,
  }) = _WithdrawMeRequest;

  factory WithdrawMeRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawMeRequestFromJson(json);
}
