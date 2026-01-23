import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mypoly/asset/index.dart';

void main() {
  test('svg assets test', () {
    expect(File(SvgImage.arrowDown).existsSync(), isTrue);
    expect(File(SvgImage.arrowLeft).existsSync(), isTrue);
    expect(File(SvgImage.arrowRight).existsSync(), isTrue);
    expect(File(SvgImage.arrowUp).existsSync(), isTrue);
    expect(File(SvgImage.icClose).existsSync(), isTrue);
    expect(File(SvgImage.icInfo).existsSync(), isTrue);
    expect(File(SvgImage.icSearch).existsSync(), isTrue);
    expect(File(SvgImage.logo).existsSync(), isTrue);
    expect(File(SvgImage.selectorCheckboxCircleOff).existsSync(), isTrue);
    expect(File(SvgImage.selectorCheckboxCircleOn).existsSync(), isTrue);
    expect(File(SvgImage.selectorCheckmarkOff).existsSync(), isTrue);
    expect(File(SvgImage.selectorCheckmarkOn).existsSync(), isTrue);
    expect(File(SvgImage.selectorRadioOff).existsSync(), isTrue);
    expect(File(SvgImage.selectorRadioOn).existsSync(), isTrue);
    expect(File(SvgImage.socialApple).existsSync(), isTrue);
    expect(File(SvgImage.socialGoogle).existsSync(), isTrue);
    expect(File(SvgImage.socialKakao).existsSync(), isTrue);
  });
}
