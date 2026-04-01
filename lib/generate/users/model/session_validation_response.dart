//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_validation_response.freezed.dart';
part 'session_validation_response.g.dart';

@freezed
abstract class SessionValidationResponse with _$SessionValidationResponse {
  const factory SessionValidationResponse({
    @JsonKey(name: r'valid') bool? valid,
  }) = _SessionValidationResponse;

  factory SessionValidationResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionValidationResponseFromJson(json);
}
