import 'package:flutter/material.dart';

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
  String formatDotDate() {
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
