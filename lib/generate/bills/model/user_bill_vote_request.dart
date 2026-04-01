//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_bill_vote_request.freezed.dart';
part 'user_bill_vote_request.g.dart';

@freezed
abstract class UserBillVoteRequest with _$UserBillVoteRequest {
  const factory UserBillVoteRequest({
    /// 투표 결과
    @JsonKey(name: r'voteResult')
    required UserBillVoteRequestVoteResultEnum voteResult,
  }) = _UserBillVoteRequest;

  factory UserBillVoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UserBillVoteRequestFromJson(json);
}

/// 투표 결과
enum UserBillVoteRequestVoteResultEnum {
  /// 투표 결과
  @JsonValue(r'AGREE')
  agree(r'AGREE'),

  /// 투표 결과
  @JsonValue(r'DISAGREE')
  disagree(r'DISAGREE'),

  /// 투표 결과
  @JsonValue(r'AGREE')
  agree2(r'AGREE'),

  /// 투표 결과
  @JsonValue(r'DISAGREE')
  disagree2(r'DISAGREE');

  const UserBillVoteRequestVoteResultEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
