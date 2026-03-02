//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_info_response.freezed.dart';
part 'address_info_response.g.dart';

@freezed
abstract class AddressInfoResponse with _$AddressInfoResponse {
  const factory AddressInfoResponse({
    /// 시도
    @JsonKey(name: r'sido') required String sido,

    /// 시군구
    @JsonKey(name: r'sigungu') required String sigungu,

    /// 읍면동
    @JsonKey(name: r'emdName') required String emdName,
  }) = _AddressInfoResponse;

  factory AddressInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressInfoResponseFromJson(json);
}
