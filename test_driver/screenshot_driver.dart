import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() {
  return integrationDriver(
    onScreenshot: (name, bytes, [args]) async {
      final directory =
          Platform.environment['SCREENSHOT_DIR'] ?? 'docs/screenshots';
      final file = File('$directory/$name.png');
      await file.create(recursive: true);
      await file.writeAsBytes(bytes, flush: true);
      return true;
    },
  );
}
