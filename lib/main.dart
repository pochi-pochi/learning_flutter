import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/authentication_service.dart';
import 'screens/introduction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthenticationService>(
      // AuthenticationServiceのインスタンスを作成
      create: (_) => AuthenticationService(FirebaseAuth.instance),
      child: MaterialApp(
        title: 'Let\'s Learning Flutter!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IntroductionScreen(), // 最初に表示する画面
      ),
    );
  }
}
