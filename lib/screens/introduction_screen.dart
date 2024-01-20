import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/authentication_service.dart';
import 'home_screen.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AuthenticationServiceを取得
    final authService = Provider.of<AuthenticationService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Let\'s Learning Flutter!'),
      backgroundColor: const Color.fromARGB(255, 52, 191, 216),
      actions: <Widget>[
        IconButton(onPressed: () async {
            // Googleでサインイン
            final googleUser = await authService.signInWithGoogle();
            if (googleUser != null) {
              print("googleログイン成功!");
              // Firebaseにサインイン
              final firebaseUser = await authService.signInWithFirebase(googleUser);
              if (firebaseUser != null) {
                // ホーム画面にナビゲート
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
            }
          }, icon: const Icon(Icons.login))
      ],),
      body: const Center(
        child: Text("Flutter学習用アプリです。"),
      ),
    );
  }
}
