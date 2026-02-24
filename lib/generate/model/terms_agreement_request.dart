//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'terms_agreement_request.freezed.dart';
part 'terms_agreement_request.g.dart';


@freezed
abstract class TermsAgreementRequest with _$TermsAgreementRequest {
  const factory TermsAgreementRequest({
    /// 약관 ID
    @JsonKey(name: r'termId')
    required int termId,
    /// 동의 여부 (true = 동의, false = 미동의)
    @JsonKey(name: r'agreed')
    required bool agreed,
  }) = _TermsAgreementRequest;

  factory TermsAgreementRequest.fromJson(Map<String, dynamic> json) => _$TermsAgreementRequestFromJson(json);
}


