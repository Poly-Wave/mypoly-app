//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_reminder_user_response.freezed.dart';
part 'onboarding_reminder_user_response.g.dart';

@freezed
abstract class OnboardingReminderUserResponse
    with _$OnboardingReminderUserResponse {
  const factory OnboardingReminderUserResponse({
    /// 사용자 ID
    @JsonKey(name: r'userId') required int userId,

    /// 닉네임(템플릿 변수 치환용, null 이면 빈 문자열)
    @JsonKey(name: r'nickname') required String nickname,
  }) = _OnboardingReminderUserResponse;

  factory OnboardingReminderUserResponse.fromJson(Map<String, dynamic> json) =>
      _$OnboardingReminderUserResponseFromJson(json);
}
