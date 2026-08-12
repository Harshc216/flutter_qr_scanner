import 'package:flutter/material.dart';

import '../controllers/qr_scanner_controller.dart';
import '../models/qr_scan_result.dart';
import '../models/qr_scanner_config.dart';
import '../widgets/qr_scanner_widget.dart';

/// A ready-to-use full-screen QR scanner.
class QRScannerScreen extends StatelessWidget {
  /// Creates a QR scanner screen.
  const QRScannerScreen({
    super.key,
    required this.onScan,
    this.config = const QRScannerConfig(),
    this.controller,
    this.onError,
    this.title = 'Scan QR Code',
    this.showAppBar = true,
  });

  /// Called when a QR code is successfully scanned.
  final ValueChanged<QRScanResult> onScan;

  /// Scanner configuration.
  final QRScannerConfig config;

  /// Optional external scanner controller.
  final QRScannerController? controller;

  /// Called when a scanner error occurs.
  final ValueChanged<Object>? onError;

  /// App bar title.
  final String title;

  /// Whether the app bar should be displayed.
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            )
          : null,
      body: QRScannerWidget(
        onScan: onScan,
        config: config,
        controller: controller,
        onError: onError,
      ),
    );
  }
}
