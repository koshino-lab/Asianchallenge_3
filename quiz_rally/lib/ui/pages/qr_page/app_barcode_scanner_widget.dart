import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final Function(String result) resultCallback;

  const BarcodeScannerWidget(this.resultCallback, {super.key});

  @override
  _BarcodeScannerWidgetState createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late Future<PermissionStatus> _permissionStatus;

  @override
  void initState() {
    super.initState();
    _permissionStatus = Permission.camera.request();
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
    return FutureBuilder<PermissionStatus>(
      future: _permissionStatus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == PermissionStatus.granted) {
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
