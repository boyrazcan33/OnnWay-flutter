// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: OnnWayFlutterApp(),
    ),
  );
}

class OnnWayFlutterApp extends StatelessWidget {
  const OnnWayFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnnWay Flutter',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Scaffold(
        body: SafeArea(
          child: OnnWayApp(),
        ),
      ),
    );
  }
}