import 'package:mobile_scanner/mobile_scanner.dart';

import '../models/qr_scan_result.dart';

/// Handles QR/barcode detection and converts scanner results
/// into the package's public [QRScanResult] model.
class QRScannerService {
  /// Converts a [BarcodeCapture] into a list of [QRScanResult].
  ///
  /// Only barcodes that contain a decoded value are returned.
  List<QRScanResult> processCapture(BarcodeCapture capture) {
    final results = <QRScanResult>[];

    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;

      if (value == null || value.isEmpty) {
        continue;
      }

      results.add(
        QRScanResult(
          value: value,
          format: barcode.format,
          rawBytes: _extractRawBytes(barcode),
        ),
      );
    }

    return results;
  }

  List<int>? _extractRawBytes(Barcode barcode) {
    final decoded = barcode.rawDecodedBytes;
    if (decoded is DecodedBarcodeBytes) {
      return decoded.bytes;
    } else if (decoded is DecodedVisionBarcodeBytes) {
      return decoded.bytes ?? decoded.rawBytes;
    }
    // ignore: deprecated_member_use
    return barcode.rawBytes;
  }

  /// Returns the first valid scan result from a capture.
  QRScanResult? processFirstResult(BarcodeCapture capture) {
    final results = processCapture(capture);

    if (results.isEmpty) {
      return null;
    }

    return results.first;
  }
}
