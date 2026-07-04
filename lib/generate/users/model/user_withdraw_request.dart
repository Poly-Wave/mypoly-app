//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_withdraw_request.freezed.dart';
part 'user_withdraw_request.g.dart';

@freezed
abstract class UserWithdrawRequest with _$UserWithdrawRequest {
  const factory UserWithdrawRequest({
    /// 탈퇴 사유(중복 선택). 가능 값: INFREQUENT_USE, MISSING_FEATURE, HARD_TO_USE, LOW_QUALITY, USING_ALTERNATIVE, ETC
    @JsonKey(name: r'reasons') List<UserWithdrawRequestReasonsEnum>? reasons,

    /// 기타(ETC) 선택 시 직접 입력한 사유. 최대 200자.
    @JsonKey(name: r'etcText') String? etcText,
  }) = _UserWithdrawRequest;

  factory UserWithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$UserWithdrawRequestFromJson(json);
}

/// 탈퇴 사유(중복 선택). 가능 값: INFREQUENT_USE, MISSING_FEATURE, HARD_TO_USE, LOW_QUALITY, USING_ALTERNATIVE, ETC
enum UserWithdrawRequestReasonsEnum {
  /// 탈퇴 사유(중복 선택). 가능 값: INFREQUENT_USE, MISSING_FEATURE, HARD_TO_USE, LOW_QUALITY, USING_ALTERNATIVE, ETC
  @JsonValue(r'INFREQUENT_USE')
  infrequentUse(r'INFREQUENT_USE'),

  /// 탈퇴 사유(중복 선택). 가능 값: INFREQUENT_USE, MISSING_FEATURE, HARD_TO_USE, LOW_QUALITY, USING_ALTERNATIVE, ETC
  @JsonValue(r'MISSING_FEATURE')
  missingFeature(r'MISSING_FEATURE'),

  /// 탈퇴 사유(중복 선택). 가능 값: INFREQUENT_USE, MISSING_FEATURE, HARD_TO_USE, LOW_QUALITY, USING_ALTERNATIVE, ETC
  @JsonValue(r'HARD_TO_USE')
  hardToUse(r'HARD_TO_USE'),

  /// 탈퇴 사유(중복 선택). 가능 값: INFREQUENT_USE, MISSING_FEATURE, HARD_TO_USE, LOW_QUALITY, USING_ALTERNATIVE, ETC
  @JsonValue(r'LOW_QUALITY')
  lowQuality(r'LOW_QUALITY'),

  /// 탈퇴 사유(중복 선택). 가능 값: INFREQUENT_USE, MISSING_FEATURE, HARD_TO_USE, LOW_QUALITY, USING_ALTERNATIVE, ETC
  @JsonValue(r'USING_ALTERNATIVE')
  usingAlternative(r'USING_ALTERNATIVE'),

  /// 탈퇴 사유(중복 선택). 가능 값: INFREQUENT_USE, MISSING_FEATURE, HARD_TO_USE, LOW_QUALITY, USING_ALTERNATIVE, ETC
  @JsonValue(r'ETC')
  etc(r'ETC');

  const UserWithdrawRequestReasonsEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
