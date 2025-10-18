import 'package:flutter/material.dart';

void main() {
  runApp(const OnnWayApp());
}

class OnnWayApp extends StatelessWidget {
  const OnnWayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnnWay Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            '🗺️ OnnWay - Flutter',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}