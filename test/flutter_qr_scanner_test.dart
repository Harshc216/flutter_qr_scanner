import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_scanner/flutter_qr_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  group('QRScannerController', () {
    test('initialization and dispose', () {
      final controller = QRScannerController();
      expect(controller.isFlashOn, isFalse);

      controller.dispose();
      expect(() => controller.start(), throwsStateError);
      expect(() => controller.stop(), throwsStateError);
      expect(() => controller.pause(), throwsStateError);
      expect(() => controller.resume(), throwsStateError);
      expect(() => controller.switchCamera(), throwsStateError);
      expect(() => controller.toggleFlash(), throwsStateError);
    });
  });

  group('QRScannerService', () {
    test('processCapture returns empty list when barcodes have no rawValue', () {
      final service = QRScannerService();
      const capture = BarcodeCapture(
        barcodes: [
          Barcode(rawValue: null),
          Barcode(rawValue: ''),
        ],
      );

      final results = service.processCapture(capture);
      expect(results, isEmpty);
    });

    test('processCapture returns valid QRScanResult', () {
      final service = QRScannerService();
      const capture = BarcodeCapture(
        barcodes: [
          Barcode(
            rawValue: 'https://example.com',
            format: BarcodeFormat.qrCode,
          ),
        ],
      );

      final results = service.processCapture(capture);
      expect(results.length, equals(1));
      expect(results.first.value, equals('https://example.com'));
      expect(results.first.format, equals(BarcodeFormat.qrCode));

      final first = service.processFirstResult(capture);
      expect(first?.value, equals('https://example.com'));
    });
  });
}
