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
