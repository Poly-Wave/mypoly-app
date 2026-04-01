//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_update_basic_profile_request.freezed.dart';
part 'user_update_basic_profile_request.g.dart';

@freezed
abstract class UserUpdateBasicProfileRequest
    with _$UserUpdateBasicProfileRequest {
  const factory UserUpdateBasicProfileRequest({
    /// 별명
    @JsonKey(name: r'nickname') required String nickname,

    /// 성별
    @JsonKey(name: r'gender')
    required UserUpdateBasicProfileRequestGenderEnum gender,

    /// 생년월일(YYYYMMDD)
    @JsonKey(name: r'birthDate') required String birthDate,

    /// 거주지역 시/도
    @JsonKey(name: r'sido') required String sido,

    /// 거주지역 시/군/구
    @JsonKey(name: r'sigungu') required String sigungu,

    /// 거주지역 읍/면/동
    @JsonKey(name: r'emdName') required String emdName,
  }) = _UserUpdateBasicProfileRequest;

  factory UserUpdateBasicProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateBasicProfileRequestFromJson(json);
}

/// 성별
enum UserUpdateBasicProfileRequestGenderEnum {
  /// 성별
  @JsonValue(r'MAN')
  man(r'MAN'),

  /// 성별
  @JsonValue(r'WOMAN')
  woman(r'WOMAN');

  const UserUpdateBasicProfileRequestGenderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
