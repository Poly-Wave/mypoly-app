//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/model/terms_agreement_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_token_signup_request.freezed.dart';
part 'social_token_signup_request.g.dart';


@freezed
abstract class SocialTokenSignupRequest with _$SocialTokenSignupRequest {
  const factory SocialTokenSignupRequest({
    /// 앱에서 전달하는 소셜 토큰 타입
    @JsonKey(name: r'tokenType')
    required SocialTokenSignupRequestTokenTypeEnum tokenType,
    /// SDK로 획득한 소셜 로그인 토큰 문자열
    @JsonKey(name: r'token')
    required String token,
    /// 설정할 닉네임
    @JsonKey(name: r'nickname')
    required String nickname,
    /// 약관 동의 목록 (최소 1개)
    @JsonKey(name: r'termAgreements')
    required List<TermsAgreementRequest> termAgreements,
  }) = _SocialTokenSignupRequest;

  factory SocialTokenSignupRequest.fromJson(Map<String, dynamic> json) => _$SocialTokenSignupRequestFromJson(json);
}

/// 앱에서 전달하는 소셜 토큰 타입
enum SocialTokenSignupRequestTokenTypeEnum {
          /// 앱에서 전달하는 소셜 토큰 타입
      @JsonValue(r'ACCESS_TOKEN')
      accessToken(r'ACCESS_TOKEN'),
          /// 앱에서 전달하는 소셜 토큰 타입
      @JsonValue(r'ID_TOKEN')
      idToken(r'ID_TOKEN');

  const SocialTokenSignupRequestTokenTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

