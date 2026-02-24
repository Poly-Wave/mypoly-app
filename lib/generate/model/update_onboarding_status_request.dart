//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_onboarding_status_request.freezed.dart';
part 'update_onboarding_status_request.g.dart';


@freezed
abstract class UpdateOnboardingStatusRequest with _$UpdateOnboardingStatusRequest {
  const factory UpdateOnboardingStatusRequest({
    /// 온보딩 상태
    @JsonKey(name: r'onboardingStatus')
    required UpdateOnboardingStatusRequestOnboardingStatusEnum onboardingStatus,
  }) = _UpdateOnboardingStatusRequest;

  factory UpdateOnboardingStatusRequest.fromJson(Map<String, dynamic> json) => _$UpdateOnboardingStatusRequestFromJson(json);
}

/// 온보딩 상태
enum UpdateOnboardingStatusRequestOnboardingStatusEnum {
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
      complete(r'COMPLETE'),
          /// 온보딩 상태
      @JsonValue(r'SIGNUP')
      signup2(r'SIGNUP'),
          /// 온보딩 상태
      @JsonValue(r'ONBOARDING')
      onboarding2(r'ONBOARDING'),
          /// 온보딩 상태
      @JsonValue(r'CATEGORY')
      category2(r'CATEGORY'),
          /// 온보딩 상태
      @JsonValue(r'COMPLETE')
      complete2(r'COMPLETE');

  const UpdateOnboardingStatusRequestOnboardingStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

