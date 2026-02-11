//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';


@freezed
abstract class ApiResponse with _$ApiResponse {
  const factory ApiResponse({
    /// 요청 성공 여부
    @JsonKey(name: r'success')
    bool? success,
    /// 응답 메시지(성공/실패 사유). 성공 시 null일 수 있습니다.
    @JsonKey(name: r'message')
    String? message,
    /// 응답 데이터. 성공 시 payload, 실패 시 null
    @JsonKey(name: r'data')
    Object? data,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
}


