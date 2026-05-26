import 'package:mypoly/generate/users/model/user_me_response.dart';
import 'package:mypoly/generate/users/model/user_update_basic_profile_request.dart';
import 'package:mypoly/generate/users/model/user_update_profile_request.dart';

enum Gender {
  man(text: "남자", me: .man, updateProfile: .man, updateBasicProfile: .man),
  woman(
    text: "여자",
    me: .woman,
    updateProfile: .woman,
    updateBasicProfile: .woman,
  );

  final String text;
  final UserMeResponseGenderEnum me;
  final UserUpdateProfileRequestGenderEnum updateProfile;
  final UserUpdateBasicProfileRequestGenderEnum updateBasicProfile;

  const Gender({
    required this.text,
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
