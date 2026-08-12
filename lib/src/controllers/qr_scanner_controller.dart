import 'package:mobile_scanner/mobile_scanner.dart';

/// Controls the QR scanner camera and scanner state.
class QRScannerController {
  /// Creates a QR scanner controller.
  QRScannerController({
    MobileScannerController? controller,
  }) : _controller = controller ?? MobileScannerController();

  final MobileScannerController _controller;

  bool _isDisposed = false;

  /// The underlying Mobile Scanner controller.
  MobileScannerController get mobileScannerController => _controller;

  /// Starts the scanner.
  Future<void> start() async {
    _checkDisposed();
    await _controller.start();
  }

  /// Stops the scanner.
  Future<void> stop() async {
    _checkDisposed();
    await _controller.stop();
  }

  /// Pauses barcode detection.
  Future<void> pause() async {
    _checkDisposed();
    await _controller.pause();
  }

  /// Resumes the scanner.
  Future<void> resume() async {
    _checkDisposed();
    await _controller.start();
  }

  /// Switches between front and back cameras.
  Future<void> switchCamera() async {
    _checkDisposed();
    await _controller.switchCamera();
  }

  /// Toggles the camera flash/torch.
  Future<void> toggleFlash() async {
    _checkDisposed();
    await _controller.toggleTorch();
  }

  /// Whether the flash is currently enabled.
  bool get isFlashOn {
    return _controller.value.torchState == TorchState.on;
  }

  /// Releases scanner resources.
  void dispose() {
    if (_isDisposed) {
      return;
    }

    _isDisposed = true;
    _controller.dispose();
  }

  void _checkDisposed() {
    if (_isDisposed) {
      throw StateError(
        'QRScannerController has already been disposed.',
      );
    }
  }
}