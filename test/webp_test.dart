import 'dart:io';

import 'package:emotion_map_app/asset/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('webp assets test', () {
    expect(File(WebpImage.onbaordLogo).existsSync(), isTrue);
    expect(File(WebpImage.socialKakao).existsSync(), isTrue);
    expect(File(WebpImage.socialNaver).existsSync(), isTrue);
  });
}
