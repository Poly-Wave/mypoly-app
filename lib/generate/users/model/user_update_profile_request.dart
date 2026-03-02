//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_update_profile_request.freezed.dart';
part 'user_update_profile_request.g.dart';

@freezed
abstract class UserUpdateProfileRequest with _$UserUpdateProfileRequest {
  const factory UserUpdateProfileRequest({
    /// 성별
    @JsonKey(name: r'gender')
    required UserUpdateProfileRequestGenderEnum gender,

    /// 생년월일(YYYYMMDD)
    @JsonKey(name: r'birthDate') required String birthDate,

    /// 거주지역 시/도
    @JsonKey(name: r'sido') required String sido,

    /// 거주지역 시/군/구
    @JsonKey(name: r'sigungu') required String sigungu,

    /// 거주지역 읍/면/동
    @JsonKey(name: r'emdName') required String emdName,
  }) = _UserUpdateProfileRequest;

  factory UserUpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateProfileRequestFromJson(json);
}

/// 성별
enum UserUpdateProfileRequestGenderEnum {
  /// 성별
  @JsonValue(r'MAN')
  man(r'MAN'),

  /// 성별
  @JsonValue(r'WOMAN')
  woman(r'WOMAN');

  const UserUpdateProfileRequestGenderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
