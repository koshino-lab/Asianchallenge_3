import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

class AnswerDialog extends StatelessWidget {
  final String riddle;
  final void Function(String answer) onSubmit;
  final VoidCallback? onCameraPressed;
  final XFile? imageFile;
  const AnswerDialog({
    super.key,
    required this.riddle,
    required this.onSubmit,
    this.onCameraPressed,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _answerController = TextEditingController();
    return AlertDialog(
      title: const Text('謎々'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(riddle),
          TextField(
            controller: _answerController,
            decoration: const InputDecoration(hintText: '解答を入力してください'),
          ),
          if (onCameraPressed != null)
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: onCameraPressed,
            ),
          if (imageFile != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: kIsWeb
                  ? FutureBuilder<Uint8List>(
                      future: imageFile!.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Image.memory(
                            snapshot.data!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )
                  : Image.file(
                      File(imageFile!.path),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
            ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _answerController.dispose();
          },
          child: const Text('閉じる'),
        ),
        TextButton(
          onPressed: () {
            onSubmit(_answerController.text);
            Navigator.of(context).pop();
            _answerController.dispose();
          },
          child: const Text('解答する'),
        ),
      ],
    );
  }
}
