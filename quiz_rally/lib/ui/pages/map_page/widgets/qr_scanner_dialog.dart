import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_rally/ui/pages/qr_page/app_barcode_scanner_widget.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';

class QrScannerDialog extends ConsumerStatefulWidget {
  const QrScannerDialog({super.key});

  @override
  _QrScannerDialogState createState() => _QrScannerDialogState();
}

class _QrScannerDialogState extends ConsumerState<QrScannerDialog> {
  String? _scanResult;

  @override
  Widget build(BuildContext context) {
    final mapPageController = ref.read(mapPageProvider.notifier);

    return AlertDialog(
      title: const Text('QRコードをスキャン'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: _scanResult != null
            ? Center(child: Text(_scanResult!))
            : BarcodeScannerWidget(
                (String code) {
                  if (_scanResult != null) return;
                  setState(() {
                    final result = mapPageController.checkQRCode(code);
                    _scanResult = result;
                  });
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
