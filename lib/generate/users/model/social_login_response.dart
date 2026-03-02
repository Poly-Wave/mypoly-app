//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_response.freezed.dart';
part 'social_login_response.g.dart';

@freezed
abstract class SocialLoginResponse with _$SocialLoginResponse {
  const factory SocialLoginResponse({
    /// MyPoly 내부 유저 ID
    @JsonKey(name: r'userId') required int userId,

    /// OAuth2 Provider
    @JsonKey(name: r'provider') required String provider,

    /// Provider 사용자 식별 값
    @JsonKey(name: r'providerUserId') required String providerUserId,

    /// 현재 닉네임 (미설정 시 null)
    @JsonKey(name: r'nickname') String? nickname,

    /// 프로필 이미지 URL
    @JsonKey(name: r'profileImageUrl') String? profileImageUrl,

    /// Access Token(JWT). 다른 서비스(bill-service 등) 호출 시 Authorization 헤더로 전달
    @JsonKey(name: r'jwt') required String jwt,

    /// Refresh Token(JWT). Access 만료 시 /auth/refresh 로 새 Access 발급에 사용
    @JsonKey(name: r'refreshToken') required String refreshToken,
  }) = _SocialLoginResponse;

  factory SocialLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginResponseFromJson(json);
}
