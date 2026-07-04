import 'package:flutter/material.dart';
import 'package:mypoly/generate/bills/model/vote_demographic_breakdown_response.dart';
import 'package:mypoly/generate/users/model/user_me_response.dart';
import 'package:mypoly/generate/users/model/user_update_basic_profile_request.dart';
import 'package:mypoly/generate/users/model/user_update_profile_request.dart';

enum Gender {
  man(
    text: "남자",
    label: "남성",
    color: Color(0xFF4C76FF),
    gradient: LinearGradient(colors: [Color(0xFF4C76FF), Color(0xFF7494FF)]),
    me: .man,
    updateProfile: .man,
    updateBasicProfile: .man,
  ),
  woman(
    text: "여자",
    label: "여성",
    color: Color(0xFFFFF36D),
    gradient: LinearGradient(colors: [Color(0xFFFFF36D), Color(0xFFFFF694)]),
    me: .woman,
    updateProfile: .woman,
    updateBasicProfile: .woman,
  );

  final String text;
  final String label;
  final Color color;
  final Gradient gradient;
  final UserMeResponseGenderEnum me;
  final UserUpdateProfileRequestGenderEnum updateProfile;
  final UserUpdateBasicProfileRequestGenderEnum updateBasicProfile;

  const Gender({
    required this.text,
    required this.label,
    required this.color,
    required this.gradient,
    required this.me,
    required this.updateProfile,
    required this.updateBasicProfile,
  });

  static Gender fromUserMeResponseGenderEnum(UserMeResponseGenderEnum value) {
    switch (value) {
      case .man:
        return .man;
      case .woman:
        return .woman;
    }
  }

  static Gender fromString(String value) {
    switch (value.toLowerCase()) {
      case 'woman':
        return .woman;
      case 'man':
      default:
        return .man;
    }
  }
}

extension VoteDemographicBreakdownResponseGenderExtension
    on VoteDemographicBreakdownResponse {
  Gender get gender => Gender.fromString(segment);
}
