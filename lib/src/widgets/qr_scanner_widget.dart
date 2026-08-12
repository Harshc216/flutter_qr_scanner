import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/qr_scanner_controller.dart';
import '../models/qr_scan_result.dart';
import '../models/qr_scanner_config.dart';
import '../services/qr_scanner_service.dart';
import 'qr_overlay.dart';
import 'qr_scanner_controls.dart';

/// A reusable QR scanner widget.
///
/// Displays the camera preview, detects QR codes, and provides
/// optional flash, camera-switch, and overlay controls.
class QRScannerWidget extends StatefulWidget {
  /// Creates a QR scanner widget.
  const QRScannerWidget({
    super.key,
    required this.onScan,
    this.config = const QRScannerConfig(),
    this.controller,
    this.onError,
  });

  /// Called when a valid QR code is detected.
  final ValueChanged<QRScanResult> onScan;

  /// Scanner configuration.
  final QRScannerConfig config;

  /// Optional external scanner controller.
  final QRScannerController? controller;

  /// Called when the scanner reports an error.
  final ValueChanged<Object>? onError;

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  late final QRScannerController _controller;
  late final QRScannerService _service;

  bool _ownsController = false;
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? QRScannerController();
    _ownsController = widget.controller == null;

    _service = QRScannerService();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }

    super.dispose();
  }

  void _handleDetection(BarcodeCapture capture) {
    if (widget.config.scanOnce && _hasScanned) {
      return;
    }

    final result = _service.processFirstResult(capture);

    if (result == null) {
      return;
    }

    if (widget.config.scanOnce) {
      _hasScanned = true;
    }

    widget.onScan(result);
  }

  void _handleScannerError(Object error, StackTrace stackTrace) {
    widget.onError?.call(error);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _controller.mobileScannerController,
          onDetect: _handleDetection,
          onDetectError: _handleScannerError,
        ),

        if (widget.config.showOverlay)
          QROverlay(
            size: widget.config.overlaySize,
            borderColor: widget.config.overlayColor,
            borderWidth: widget.config.overlayBorderWidth,
            borderRadius: widget.config.overlayBorderRadius,
          ),

        if (widget.config.showFlashButton ||
            widget.config.showCameraSwitchButton)
          Align(
            alignment: widget.config.controlsAlignment,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: QRScannerControls(
                controller: _controller,
                showFlashButton: widget.config.showFlashButton,
                showCameraSwitchButton: widget.config.showCameraSwitchButton,
              ),
            ),
          ),
      ],
    );
  }
}
