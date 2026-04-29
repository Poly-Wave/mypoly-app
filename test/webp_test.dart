import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mypoly/asset/index.dart';

void main() {
  test('webp assets test', () {
    expect(File(WebpImage.btnMainHomeBookmark).existsSync(), isTrue);
    expect(File(WebpImage.btnMainHomeVote).existsSync(), isTrue);
    expect(File(WebpImage.emptyProfile).existsSync(), isTrue);
    expect(File(WebpImage.loading).existsSync(), isTrue);
    expect(File(WebpImage.popular1).existsSync(), isTrue);
    expect(File(WebpImage.popular2).existsSync(), isTrue);
    expect(File(WebpImage.popular3).existsSync(), isTrue);
    expect(File(WebpImage.registerComplete).existsSync(), isTrue);
    expect(File(WebpImage.registerOnboard).existsSync(), isTrue);
    expect(File(WebpImage.viewCount).existsSync(), isTrue);
    expect(File(WebpImage.voteCount).existsSync(), isTrue);
  });
}
