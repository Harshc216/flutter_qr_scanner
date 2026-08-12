import 'package:flutter/material.dart';

/// Displays the scanning area overlay on top of the camera preview.
class QROverlay extends StatelessWidget {
  /// Creates a QR scanner overlay.
  const QROverlay({
    super.key,
    this.size = 260,
    this.borderColor = Colors.white,
    this.borderWidth = 3,
    this.borderRadius = 20,
    this.overlayColor = const Color(0x99000000),
    this.cornerLength = 30,
  });

  /// Size of the scanning area.
  final double size;

  /// Color of the scanning border.
  final Color borderColor;

  /// Width of the scanning border.
  final double borderWidth;

  /// Radius of the scanning area corners.
  final double borderRadius;

  /// Color used to darken the area outside the scanner.
  final Color overlayColor;

  /// Length of each corner indicator.
  final double cornerLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _QROverlayPainter(
          size: size,
          borderColor: borderColor,
          borderWidth: borderWidth,
          borderRadius: borderRadius,
          overlayColor: overlayColor,
          cornerLength: cornerLength,
        ),
      ),
    );
  }
}

/// Paints the QR scanning overlay.
class _QROverlayPainter extends CustomPainter {
  _QROverlayPainter({
    required this.size,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.overlayColor,
    required this.cornerLength,
  });

  final double size;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Color overlayColor;
  final double cornerLength;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final left = (canvasSize.width - size) / 2;
    final top = (canvasSize.height - size) / 2;

    final scanRect = Rect.fromLTWH(left, top, size, size);

    final scanPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(scanRect, Radius.circular(borderRadius)),
      );

    final overlayPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final fullPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, canvasSize.width, canvasSize.height));

    final outsidePath = Path.combine(
      PathOperation.difference,
      fullPath,
      scanPath,
    );

    canvas.drawPath(outsidePath, overlayPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(
      RRect.fromRectAndRadius(scanRect, Radius.circular(borderRadius)),
      borderPaint,
    );

    _drawCorners(canvas, scanRect, borderPaint);
  }

  void _drawCorners(Canvas canvas, Rect rect, Paint paint) {
    final path = Path();

    // Top-left.
    path
      ..moveTo(rect.left, rect.top + cornerLength)
      ..lineTo(rect.left, rect.top)
      ..lineTo(rect.left + cornerLength, rect.top);

    // Top-right.
    path
      ..moveTo(rect.right - cornerLength, rect.top)
      ..lineTo(rect.right, rect.top)
      ..lineTo(rect.right, rect.top + cornerLength);

    // Bottom-right.
    path
      ..moveTo(rect.right, rect.bottom - cornerLength)
      ..lineTo(rect.right, rect.bottom)
      ..lineTo(rect.right - cornerLength, rect.bottom);

    // Bottom-left.
    path
      ..moveTo(rect.left + cornerLength, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.bottom - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _QROverlayPainter oldDelegate) {
    return oldDelegate.size != size ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.overlayColor != overlayColor ||
        oldDelegate.cornerLength != cornerLength;
  }
}
