import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:quiz_rally/gen/assets.gen.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('成功')),
      body: Container(
        color: Styles.primaryColor,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            // 背景画像（フィルター画像）
            Positioned.fill(
              child: Image.asset(
                Assets.images.succesPage.path,
                fit: BoxFit.cover,
              ),
            ),
            // 成功ページの画像（上に重ねる）
            Positioned.fill(
              child: Image.asset(
                Assets.images.succesPage2.path,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
