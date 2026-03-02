import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mypoly/asset/index.dart';

void main() {
  test('lottie assets test', () {
    expect(File(LottieFile.registerOnboard1).existsSync(), isTrue);
    expect(File(LottieFile.registerOnboard2).existsSync(), isTrue);
    expect(File(LottieFile.registerOnboard3).existsSync(), isTrue);
  });
}
