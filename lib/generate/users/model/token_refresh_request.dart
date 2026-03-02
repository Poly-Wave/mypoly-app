//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_refresh_request.freezed.dart';
part 'token_refresh_request.g.dart';

@freezed
abstract class TokenRefreshRequest with _$TokenRefreshRequest {
  const factory TokenRefreshRequest({
    /// Refresh Token(JWT)
    @JsonKey(name: r'refreshToken') required String refreshToken,
  }) = _TokenRefreshRequest;

  factory TokenRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshRequestFromJson(json);
}
