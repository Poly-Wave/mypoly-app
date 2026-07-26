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
    /// 탈퇴 사유(중복 선택). 코드 값: - INFREQUENT_USE: 사용하는 빈도가 낮아요 - MISSING_FEATURE: 원하는 기능이 없어요 - HARD_TO_USE: 사용방법이 어렵고 불편해요 - LOW_QUALITY: 결과물 품질이 기대와 달라요 - USING_ALTERNATIVE: 다른 유사 서비스를 이용해요 - ETC: 기타
    @JsonKey(name: r'reasons') List<UserWithdrawRequestReasonsEnum>? reasons,

    /// 기타(ETC) 선택 시 직접 입력한 사유. 최대 200자.
    @JsonKey(name: r'etcText') String? etcText,
  }) = _UserWithdrawRequest;

  factory UserWithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$UserWithdrawRequestFromJson(json);
}

/// 탈퇴 사유(중복 선택). 코드 값: - INFREQUENT_USE: 사용하는 빈도가 낮아요 - MISSING_FEATURE: 원하는 기능이 없어요 - HARD_TO_USE: 사용방법이 어렵고 불편해요 - LOW_QUALITY: 결과물 품질이 기대와 달라요 - USING_ALTERNATIVE: 다른 유사 서비스를 이용해요 - ETC: 기타
enum UserWithdrawRequestReasonsEnum {
  /// 탈퇴 사유(중복 선택). 코드 값: - INFREQUENT_USE: 사용하는 빈도가 낮아요 - MISSING_FEATURE: 원하는 기능이 없어요 - HARD_TO_USE: 사용방법이 어렵고 불편해요 - LOW_QUALITY: 결과물 품질이 기대와 달라요 - USING_ALTERNATIVE: 다른 유사 서비스를 이용해요 - ETC: 기타
  @JsonValue(r'INFREQUENT_USE')
  infrequentUse(r'INFREQUENT_USE'),

  /// 탈퇴 사유(중복 선택). 코드 값: - INFREQUENT_USE: 사용하는 빈도가 낮아요 - MISSING_FEATURE: 원하는 기능이 없어요 - HARD_TO_USE: 사용방법이 어렵고 불편해요 - LOW_QUALITY: 결과물 품질이 기대와 달라요 - USING_ALTERNATIVE: 다른 유사 서비스를 이용해요 - ETC: 기타
  @JsonValue(r'MISSING_FEATURE')
  missingFeature(r'MISSING_FEATURE'),

  /// 탈퇴 사유(중복 선택). 코드 값: - INFREQUENT_USE: 사용하는 빈도가 낮아요 - MISSING_FEATURE: 원하는 기능이 없어요 - HARD_TO_USE: 사용방법이 어렵고 불편해요 - LOW_QUALITY: 결과물 품질이 기대와 달라요 - USING_ALTERNATIVE: 다른 유사 서비스를 이용해요 - ETC: 기타
  @JsonValue(r'HARD_TO_USE')
  hardToUse(r'HARD_TO_USE'),

  /// 탈퇴 사유(중복 선택). 코드 값: - INFREQUENT_USE: 사용하는 빈도가 낮아요 - MISSING_FEATURE: 원하는 기능이 없어요 - HARD_TO_USE: 사용방법이 어렵고 불편해요 - LOW_QUALITY: 결과물 품질이 기대와 달라요 - USING_ALTERNATIVE: 다른 유사 서비스를 이용해요 - ETC: 기타
  @JsonValue(r'LOW_QUALITY')
  lowQuality(r'LOW_QUALITY'),

  /// 탈퇴 사유(중복 선택). 코드 값: - INFREQUENT_USE: 사용하는 빈도가 낮아요 - MISSING_FEATURE: 원하는 기능이 없어요 - HARD_TO_USE: 사용방법이 어렵고 불편해요 - LOW_QUALITY: 결과물 품질이 기대와 달라요 - USING_ALTERNATIVE: 다른 유사 서비스를 이용해요 - ETC: 기타
  @JsonValue(r'USING_ALTERNATIVE')
  usingAlternative(r'USING_ALTERNATIVE'),

  /// 탈퇴 사유(중복 선택). 코드 값: - INFREQUENT_USE: 사용하는 빈도가 낮아요 - MISSING_FEATURE: 원하는 기능이 없어요 - HARD_TO_USE: 사용방법이 어렵고 불편해요 - LOW_QUALITY: 결과물 품질이 기대와 달라요 - USING_ALTERNATIVE: 다른 유사 서비스를 이용해요 - ETC: 기타
  @JsonValue(r'ETC')
  etc(r'ETC');

  const UserWithdrawRequestReasonsEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
