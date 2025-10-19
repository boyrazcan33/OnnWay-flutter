// test_driver/app.dart
import 'package:flutter_driver/driver_extension.dart';
import 'package:onnway_flutter/main.dart' as app;

void main() {
  // Enable Flutter Driver extension
  enableFlutterDriverExtension();

  // Run the app
  app.main();
}