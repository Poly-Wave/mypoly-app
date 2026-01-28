import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mypoly/asset/index.dart';

void main() {
  test('webp assets test', () {
    expect(File(WebpImage.categoryAuth).existsSync(), isTrue);
    expect(File(WebpImage.categoryBangtong).existsSync(), isTrue);
    expect(File(WebpImage.categoryEconomy).existsSync(), isTrue);
    expect(File(WebpImage.loading).existsSync(), isTrue);
  });
}
