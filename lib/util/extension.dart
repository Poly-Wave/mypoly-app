import 'package:flutter/material.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';

extension FocusScopeNodeExtension on FocusScopeNode {
  void unFocus() {
    unfocus();
    requestFocus(FocusNode());
  }
}

extension BuildContextExtension on BuildContext {
  void unFocus() => FocusScope.of(this).unFocus();
}

extension DateTimeExtension on DateTime {
  String get toDashYMD {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, "0");
    final day = this.day.toString().padLeft(2, "0");

    return "$year-$month-$day";
  }

  String get toDotYMD {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, "0");
    final day = this.day.toString().padLeft(2, "0");

    return "$year.$month.$day";
  }

  DateTime subtractMonths(int months) {
    final targetMonth = month - months;
    final lastDayOfTargetMonth = DateTime(year, targetMonth + 1, 0).day;

    return DateTime(year, targetMonth, day.clamp(1, lastDayOfTargetMonth));
  }
}

extension CategoryResponseExtension on CategoryResponse {
  Color get colorBackground => Color(int.parse("0xFF$backgroundColor"));

  Color get colorBadgeBackground =>
      Color(int.parse("0xFF$badgeBackgroundColor"));

  Color get colorBadgeTextColor => Color(int.parse("0xFF$textColor"));
}

extension StringExtension on String {
  String get wrapped {
    if (!contains(RegExp('[ㄱ-ㅎㅏ-ㅣ가-힣]'))) {
      return this;
    }

    final emoji = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
    );
    final fullText = StringBuffer();

    final lines = split('\n');
    for (var lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      final words = lines[lineIndex].split(' ');
      for (var i = 0; i < words.length; i++) {
        fullText.write(
          emoji.hasMatch(words[i])
              ? words[i]
              : words[i].replaceAllMapped(
                  RegExp(r'(\S)(?=\S)'),
                  (match) => '${match[1]}\u200D',
                ),
        );
        if (i < words.length - 1) {
          fullText.write(' ');
        }
      }
      if (lineIndex < lines.length - 1) {
        fullText.write('\n');
      }
    }
    return fullText.toString();
  }

  String get toDotBirthDate {
    final digits = replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return '';
    if (digits.length <= 4) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 4)}.${digits.substring(4)}';
    }
    return '${digits.substring(0, 4)}.${digits.substring(4, 6)}.${digits.substring(6)}';
  }

  int get age {
    final normalizedBirthDate = replaceAll(RegExp(r'[^0-9]'), '');
    if (normalizedBirthDate.length != 8) return 0;

    final year = int.tryParse(normalizedBirthDate.substring(0, 4));
    final month = int.tryParse(normalizedBirthDate.substring(4, 6));
    final day = int.tryParse(normalizedBirthDate.substring(6, 8));

    if (year == null || month == null || day == null) return 0;

    final birth = DateTime(year, month, day);
    if (birth.year != year || birth.month != month || birth.day != day) {
      return 0;
    }

    final now = DateTime.now();
    if (birth.isAfter(now)) return 0;

    var age = now.year - year;
    final hasBirthdayPassed =
        now.month > month || (now.month == month && now.day >= day);

    if (!hasBirthdayPassed) {
      age -= 1;
    }

    return age;
  }
}
