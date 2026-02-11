//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nickname_create_request.freezed.dart';
part 'nickname_create_request.g.dart';


@freezed
abstract class NicknameCreateRequest with _$NicknameCreateRequest {
  const factory NicknameCreateRequest({
    /// 설정할 닉네임
    @JsonKey(name: r'nickname')
    required String nickname,
  }) = _NicknameCreateRequest;

  factory NicknameCreateRequest.fromJson(Map<String, dynamic> json) => _$NicknameCreateRequestFromJson(json);
}


