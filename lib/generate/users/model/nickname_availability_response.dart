//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nickname_availability_response.freezed.dart';
part 'nickname_availability_response.g.dart';

@freezed
abstract class NicknameAvailabilityResponse
    with _$NicknameAvailabilityResponse {
  const factory NicknameAvailabilityResponse({
    /// 사용 가능 여부
    @JsonKey(name: r'available') required bool available,

    /// 닉네임 사용 가능 상태 코드
    @JsonKey(name: r'status')
    required NicknameAvailabilityResponseStatusEnum status,
  }) = _NicknameAvailabilityResponse;

  factory NicknameAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$NicknameAvailabilityResponseFromJson(json);
}

/// 닉네임 사용 가능 상태 코드
enum NicknameAvailabilityResponseStatusEnum {
  /// 닉네임 사용 가능 상태 코드
  @JsonValue(r'AVAILABLE')
  available(r'AVAILABLE'),

  /// 닉네임 사용 가능 상태 코드
  @JsonValue(r'DUPLICATED')
  duplicated(r'DUPLICATED'),

  /// 닉네임 사용 가능 상태 코드
  @JsonValue(r'FORBIDDEN')
  forbidden(r'FORBIDDEN');

  const NicknameAvailabilityResponseStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
