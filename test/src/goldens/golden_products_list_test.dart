import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:only_sales/src/app.dart';

import '../robot.dart';

void main() {
  final sizeVariant = ValueVariant<Size>({
    const Size(300, 600),
    const Size(600, 800),
    const Size(1000, 1000),
  });
  testWidgets(
    'Golden - products list',
    (tester) async {
      final currentSize = sizeVariant.currentValue!;
      final Robot robot = Robot(tester);
      await robot.golden.setSurfaceSize(currentSize);
      await robot.golden.loadRobotoFont();
      await robot.golden.loadMaterialIconFont();
      await robot.pumpMyApp();
      await robot.golden.precacheImages();
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile(
          'products_list_${currentSize.width.toInt()}x${currentSize.height.toInt()}.png',
        ),
      );
    },
    variant: sizeVariant,
    tags: ['golden'],
    // Skip this test until we can run it successfully on CI without this error:
    // Golden "products_list_300x600.png": Pixel test failed, 2.33% diff detected.
    skip: true,
  );
}
