import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/authentication_service.dart';
import 'home_screen.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Let\'s Learning Flutter!'),
      backgroundColor: const Color.fromARGB(255, 52, 191, 216),
      actions: <Widget>[
        IconButton(onPressed: (){
          context.read<AuthenticationService>().signInWithGoogle();
        }, icon: const Icon(Icons.login))
      ],),
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
