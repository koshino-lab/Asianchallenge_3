import 'package:flutter/material.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Object? message = ModalRoute.of(context)?.settings.arguments;
    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: message != null
                    ? GrayText(message as String, shortestSide / 19)
                    : GrayText('エラー', shortestSide / 19),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed('/');
                },
                child: const Text('ホームに戻る'))
          ],
        ));
  }
}
