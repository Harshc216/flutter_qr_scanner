import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const QRScannerExampleApp());
}

/// Example application for flutter_qr_scanner.
class QRScannerExampleApp extends StatelessWidget {
  /// Creates the example application.
  const QRScannerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
