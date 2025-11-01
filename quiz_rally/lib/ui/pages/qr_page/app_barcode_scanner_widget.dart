import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Conditional import for dart:html
import 'package:universal_html/html.dart' if (dart.library.html) 'dart:html' as html;

class BarcodeScannerWidget extends StatefulWidget {
  final Function(String result) resultCallback;

  const BarcodeScannerWidget(this.resultCallback, {super.key});

  @override
  _BarcodeScannerWidgetState createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late Future<bool> _permissionGranted;

  @override
  void initState() {
    super.initState();
    _permissionGranted = _checkCameraPermission();
  }

  Future<bool> _checkCameraPermission() async {
    if (kIsWeb) {
      // For web, use dart:html to check permissions
      try {
        print('Web navigator: ${html.window.navigator}');
        print('Web mediaDevices: ${html.window.navigator.mediaDevices}');

        final perm = await html.window.navigator.permissions?.query({'name': 'camera'});
        if (perm?.state == 'granted') {
          return true;
        } else if (perm?.state == 'prompt') {
          // Attempt to get user media to trigger the prompt
          try {
            await html.window.navigator.mediaDevices?.getUserMedia({'video': true});
            return true;
          } catch (e) {
            print('Web camera permission denied after prompt: $e');
            return false;
          }
        } else {
          print('Web camera permission state: ${perm?.state}');
          return false;
        }
      } catch (e) {
        print('Error checking web camera permission: $e');
        return false;
      }
    } else {
      // For native platforms, use permission_handler
      final status = await Permission.camera.request();
      return status.isGranted;
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _permissionGranted,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data == true) {
            return QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            );
          } else {
            return const Center(
              child: Text('カメラの権限がありません'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      widget.resultCallback(scanData.code ?? '');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}