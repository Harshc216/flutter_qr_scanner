import 'package:flutter/material.dart';

import '../../flutter_qr_scanner.dart';

class QRScannerControls extends StatefulWidget {
  const QRScannerControls({
    super.key,
    required this.controller,
    this.showFlashButton = true,
    this.showCameraSwitchButton = true,
    this.iconColor = Colors.white,
    this.buttonBackgroundColor = const Color(0x66000000),
    this.spacing = 24,
  });

  final QRScannerController controller;
  final bool showFlashButton;
  final bool showCameraSwitchButton;
  final Color iconColor;
  final Color buttonBackgroundColor;
  final double spacing;

  @override
  State<QRScannerControls> createState() => _QRScannerControlsState();
}

class _QRScannerControlsState extends State<QRScannerControls> {
  bool _isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];

    if (widget.showFlashButton) {
      buttons.add(
        _ScannerControlButton(
          icon: _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
          onPressed: _toggleFlash,
          iconColor: widget.iconColor,
          backgroundColor: widget.buttonBackgroundColor,
        ),
      );
    }

    if (widget.showCameraSwitchButton) {
      buttons.add(
        _ScannerControlButton(
          icon: Icons.flip_camera_ios_rounded,
          onPressed: _switchCamera,
          iconColor: widget.iconColor,
          backgroundColor: widget.buttonBackgroundColor,
        ),
      );
    }

    if (buttons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(mainAxisSize: MainAxisSize.min, children: _addSpacing(buttons));
  }

  Future<void> _toggleFlash() async {
    try {
      await widget.controller.toggleFlash();

      if (!mounted) return;

      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (_) {}
  }

  Future<void> _switchCamera() async {
    try {
      await widget.controller.switchCamera();
    } catch (_) {}
  }

  List<Widget> _addSpacing(List<Widget> widgets) {
    final result = <Widget>[];

    for (var i = 0; i < widgets.length; i++) {
      if (i > 0) {
        result.add(SizedBox(width: widget.spacing));
      }

      result.add(widgets[i]);
    }

    return result;
  }
}

class _ScannerControlButton extends StatelessWidget {
  const _ScannerControlButton({
    required this.icon,
    required this.onPressed,
    required this.iconColor,
    required this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: CircleBorder(),
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, color: iconColor, size: 26),
        ),
      ),
    );
  }
}
