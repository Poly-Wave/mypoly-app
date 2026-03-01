//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_nickname_response.freezed.dart';
part 'random_nickname_response.g.dart';

@freezed
abstract class RandomNicknameResponse with _$RandomNicknameResponse {
  const factory RandomNicknameResponse({
    /// 서버가 생성한 랜덤 닉네임
    @JsonKey(name: r'nickname') required String nickname,
  }) = _RandomNicknameResponse;

  factory RandomNicknameResponse.fromJson(Map<String, dynamic> json) =>
      _$RandomNicknameResponseFromJson(json);
}
