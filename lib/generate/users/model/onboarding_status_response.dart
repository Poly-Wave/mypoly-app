//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_status_response.freezed.dart';
part 'onboarding_status_response.g.dart';

@freezed
abstract class OnboardingStatusResponse with _$OnboardingStatusResponse {
  const factory OnboardingStatusResponse({
    /// 온보딩 상태
    @JsonKey(name: r'onboardingStatus')
    required OnboardingStatusResponseOnboardingStatusEnum onboardingStatus,
  }) = _OnboardingStatusResponse;

  factory OnboardingStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStatusResponseFromJson(json);
}

/// 온보딩 상태
enum OnboardingStatusResponseOnboardingStatusEnum {
  /// 온보딩 상태
  @JsonValue(r'SIGNUP')
  signup(r'SIGNUP'),

  /// 온보딩 상태
  @JsonValue(r'ONBOARDING')
  onboarding(r'ONBOARDING'),

  /// 온보딩 상태
  @JsonValue(r'CATEGORY')
  category(r'CATEGORY'),

  /// 온보딩 상태
  @JsonValue(r'COMPLETE')
  complete(r'COMPLETE');

  const OnboardingStatusResponseOnboardingStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
