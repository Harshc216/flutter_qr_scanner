import 'package:mobile_scanner/mobile_scanner.dart';

/// Represents the result of a successful QR code scan.
///
/// Contains the decoded value along with information about
/// the barcode format and raw bytes when available.
class QRScanResult {
  /// Creates a QR scan result.
  const QRScanResult({
    required this.value,
    required this.format,
    this.rawBytes,
  });

  /// The decoded value from the QR code.
  final String value;

  /// The format of the scanned code.
  final BarcodeFormat format;

  /// Raw bytes returned by the scanner, when available.
  final List<int>? rawBytes;

  @override
  String toString() {
    return 'QRScanResult('
        'value: $value, '
        'format: $format, '
        'rawBytes: $rawBytes'
        ')';
  }
}
