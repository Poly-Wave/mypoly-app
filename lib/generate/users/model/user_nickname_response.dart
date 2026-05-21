//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_nickname_response.freezed.dart';
part 'user_nickname_response.g.dart';

@freezed
abstract class UserNicknameResponse with _$UserNicknameResponse {
  const factory UserNicknameResponse({
    /// 사용자 ID
    @JsonKey(name: r'userId') required int userId,

    /// 닉네임 (없으면 빈 문자열)
    @JsonKey(name: r'nickname') required String nickname,
  }) = _UserNicknameResponse;

  factory UserNicknameResponse.fromJson(Map<String, dynamic> json) =>
      _$UserNicknameResponseFromJson(json);
}
