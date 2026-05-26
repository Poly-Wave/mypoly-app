import 'package:mypoly/generate/users/model/user_me_response.dart';
import 'package:mypoly/generate/users/model/user_update_profile_request.dart';

enum Gender {
  man(text: "남자", updateProfile: .man),
  woman(text: "여자", updateProfile: .woman);

  final String text;
  final UserUpdateProfileRequestGenderEnum updateProfile;

  const Gender({required this.text, required this.updateProfile});

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
