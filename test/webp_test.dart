import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mypoly/asset/index.dart';

void main() {
  test('webp assets test', () {
    expect(File(WebpImage.emptyProfile).existsSync(), isTrue);
    expect(File(WebpImage.loading).existsSync(), isTrue);
    expect(File(WebpImage.registerComplete).existsSync(), isTrue);
    expect(File(WebpImage.registerOnboard).existsSync(), isTrue);
  });
}
