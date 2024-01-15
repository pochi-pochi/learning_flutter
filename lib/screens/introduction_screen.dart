import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/authentication_service.dart';
import 'home_screen.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('アプリの概要')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('このアプリの概要を説明するテキスト'),
            ElevatedButton(
              child: Text('Googleでログイン'),
              onPressed: () {
                // Googleログインの処理
              },
            ),
          ],
        ),
      ),
    );
  }
}
