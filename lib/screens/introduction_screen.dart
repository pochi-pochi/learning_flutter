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
      appBar: AppBar(title: const Text('Let\'s Learning Flutter!',
      style: TextStyle(color: Colors.white),),
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
      backgroundColor: Color.fromARGB(255, 146, 224, 238),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ここから説明
            Padding(
              padding: EdgeInsets.fromLTRB(400, 30, 400, 0),
              child: Text(
                'Flutterを学ぼう！',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: Text(
                'Flutter!\n'
                '詳細な説明とか書いてくよ!',
              ),
            ),     
          ],
        ),
      ),
    );
  }
}
