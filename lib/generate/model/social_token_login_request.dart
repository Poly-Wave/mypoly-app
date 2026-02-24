//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_token_login_request.freezed.dart';
part 'social_token_login_request.g.dart';


@freezed
abstract class SocialTokenLoginRequest with _$SocialTokenLoginRequest {
  const factory SocialTokenLoginRequest({
    /// 앱에서 전달하는 소셜 토큰 타입
    @JsonKey(name: r'tokenType')
    required SocialTokenLoginRequestTokenTypeEnum tokenType,
    /// SDK로 획득한 토큰 문자열
    @JsonKey(name: r'token')
    required String token,
  }) = _SocialTokenLoginRequest;

  factory SocialTokenLoginRequest.fromJson(Map<String, dynamic> json) => _$SocialTokenLoginRequestFromJson(json);
}

/// 앱에서 전달하는 소셜 토큰 타입
enum SocialTokenLoginRequestTokenTypeEnum {
          /// 앱에서 전달하는 소셜 토큰 타입
      @JsonValue(r'ACCESS_TOKEN')
      accessToken(r'ACCESS_TOKEN'),
          /// 앱에서 전달하는 소셜 토큰 타입
      @JsonValue(r'ID_TOKEN')
      idToken(r'ID_TOKEN');

  const SocialTokenLoginRequestTokenTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

