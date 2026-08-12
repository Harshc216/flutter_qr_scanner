import 'package:flutter/material.dart';

/// Configuration options for the QR scanner.
class QRScannerConfig {
  /// Creates a QR scanner configuration.
  const QRScannerConfig({
    this.scanOnce = true,
    this.showOverlay = true,
    this.showFlashButton = true,
    this.showCameraSwitchButton = true,
    this.overlaySize = 260,
    this.overlayColor = Colors.white,
    this.overlayBorderWidth = 3,
    this.overlayBorderRadius = 20,
    this.controlsAlignment = Alignment.bottomCenter,
  }) : assert(overlaySize > 0, 'overlaySize must be greater than 0.'),
       assert(
         overlayBorderWidth >= 0,
         'overlayBorderWidth cannot be negative.',
       ),
       assert(
         overlayBorderRadius >= 0,
         'overlayBorderRadius cannot be negative.',
       );

  /// Whether only the first detected QR code should be returned.
  final bool scanOnce;

  /// Whether the scanning overlay should be displayed.
  final bool showOverlay;

  /// Whether the flash button should be displayed.
  final bool showFlashButton;

  /// Whether the camera switch button should be displayed.
  final bool showCameraSwitchButton;

  /// Size of the square scanning area.
  final double overlaySize;

  /// Border color of the scanning area.
  final Color overlayColor;

  /// Border width of the scanning area.
  final double overlayBorderWidth;

  /// Border radius of the scanning area.
  final double overlayBorderRadius;

  /// Alignment of the scanner controls.
  final Alignment controlsAlignment;

  /// Creates a copy with modified values.
  QRScannerConfig copyWith({
    bool? scanOnce,
    bool? showOverlay,
    bool? showFlashButton,
    bool? showCameraSwitchButton,
    double? overlaySize,
    Color? overlayColor,
    double? overlayBorderWidth,
    double? overlayBorderRadius,
    Alignment? controlsAlignment,
  }) {
    return QRScannerConfig(
      scanOnce: scanOnce ?? this.scanOnce,
      showOverlay: showOverlay ?? this.showOverlay,
      showFlashButton: showFlashButton ?? this.showFlashButton,
      showCameraSwitchButton:
          showCameraSwitchButton ?? this.showCameraSwitchButton,
      overlaySize: overlaySize ?? this.overlaySize,
      overlayColor: overlayColor ?? this.overlayColor,
      overlayBorderWidth: overlayBorderWidth ?? this.overlayBorderWidth,
      overlayBorderRadius: overlayBorderRadius ?? this.overlayBorderRadius,
      controlsAlignment: controlsAlignment ?? this.controlsAlignment,
    );
  }
}
