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
  }) = _NicknameAvailabilityResponse;

  factory NicknameAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$NicknameAvailabilityResponseFromJson(json);
}
