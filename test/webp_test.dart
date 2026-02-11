import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mypoly/asset/index.dart';

void main() {
  test('webp assets test', () {
    expect(File(WebpImage.categoryBangtong).existsSync(), isTrue);
    expect(File(WebpImage.categoryChild).existsSync(), isTrue);
    expect(File(WebpImage.categoryDigital).existsSync(), isTrue);
    expect(File(WebpImage.categoryDiplomacy).existsSync(), isTrue);
    expect(File(WebpImage.categoryEconomy).existsSync(), isTrue);
    expect(File(WebpImage.categoryEducation).existsSync(), isTrue);
    expect(File(WebpImage.categoryEnvironment).existsSync(), isTrue);
    expect(File(WebpImage.categoryFamily).existsSync(), isTrue);
    expect(File(WebpImage.categoryFemale).existsSync(), isTrue);
    expect(File(WebpImage.categoryLabor).existsSync(), isTrue);
    expect(File(WebpImage.categoryLaw).existsSync(), isTrue);
    expect(File(WebpImage.categoryMedical).existsSync(), isTrue);
    expect(File(WebpImage.categoryRealEstate).existsSync(), isTrue);
    expect(File(WebpImage.categorySecurity).existsSync(), isTrue);
    expect(File(WebpImage.categorySexCrime).existsSync(), isTrue);
    expect(File(WebpImage.categoryTraffic).existsSync(), isTrue);
    expect(File(WebpImage.categoryWelfare).existsSync(), isTrue);
    expect(File(WebpImage.loading).existsSync(), isTrue);
    expect(File(WebpImage.registerComplete).existsSync(), isTrue);
    expect(File(WebpImage.registerOnboard1).existsSync(), isTrue);
    expect(File(WebpImage.registerOnboard2).existsSync(), isTrue);
    expect(File(WebpImage.registerOnboard3).existsSync(), isTrue);
    expect(File(WebpImage.registerOnboard4).existsSync(), isTrue);
  });
}
