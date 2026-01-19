import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mypoly/asset/index.dart';

void main() {
  test('svg assets test', () {
    expect(File(SvgImage.logo).existsSync(), isTrue);
    expect(File(SvgImage.socialApple).existsSync(), isTrue);
    expect(File(SvgImage.socialGoogle).existsSync(), isTrue);
    expect(File(SvgImage.socialKakao).existsSync(), isTrue);
  });
}
