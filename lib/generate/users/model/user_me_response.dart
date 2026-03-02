//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_me_response.freezed.dart';
part 'user_me_response.g.dart';

@freezed
abstract class UserMeResponse with _$UserMeResponse {
  const factory UserMeResponse({
    /// 사용자 ID
    @JsonKey(name: r'userId') int? userId,

    /// 소셜 provider
    @JsonKey(name: r'provider') String? provider,

    /// 소셜 provider user id
    @JsonKey(name: r'providerUserId') String? providerUserId,

    /// 닉네임
    @JsonKey(name: r'nickname') String? nickname,

    /// 온보딩 상태
    @JsonKey(name: r'onboardingStatus')
    UserMeResponseOnboardingStatusEnum? onboardingStatus,

    /// 성별
    @JsonKey(name: r'gender') UserMeResponseGenderEnum? gender,

    /// 생년월일(YYYYMMDD)
    @JsonKey(name: r'birthDate') String? birthDate,

    /// 프로필 이미지 URL
    @JsonKey(name: r'profileImageUrl') String? profileImageUrl,

    /// 시/도
    @JsonKey(name: r'sido') String? sido,

    /// 시/군/구
    @JsonKey(name: r'sigungu') String? sigungu,

    /// 읍/면/동
    @JsonKey(name: r'emdName') String? emdName,

    /// 상세 주소
    @JsonKey(name: r'address') String? address,
  }) = _UserMeResponse;

  factory UserMeResponse.fromJson(Map<String, dynamic> json) =>
      _$UserMeResponseFromJson(json);
}

/// 온보딩 상태
enum UserMeResponseOnboardingStatusEnum {
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

  const UserMeResponseOnboardingStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

/// 성별
enum UserMeResponseGenderEnum {
  /// 성별
  @JsonValue(r'MAN')
  man(r'MAN'),

  /// 성별
  @JsonValue(r'WOMAN')
  woman(r'WOMAN');

  const UserMeResponseGenderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
