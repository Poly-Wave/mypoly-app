//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mypoly/generate/model/terms_agreement_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_agreement_request.freezed.dart';
part 'user_agreement_request.g.dart';


@freezed
abstract class UserAgreementRequest with _$UserAgreementRequest {
  const factory UserAgreementRequest({
    /// 약관 동의 목록 (최소 1개)
    @JsonKey(name: r'termAgreements')
    required List<TermsAgreementRequest> termAgreements,
  }) = _UserAgreementRequest;

  factory UserAgreementRequest.fromJson(Map<String, dynamic> json) => _$UserAgreementRequestFromJson(json);
}


