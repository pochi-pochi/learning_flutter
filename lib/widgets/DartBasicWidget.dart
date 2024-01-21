import 'package:flutter/material.dart';
import 'package:learning_flutter/screens/DartBaicScreen.dart';


class DartBasicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DartBasicScreen()),
        );
      },
      child: const Card(
        child: ListTile(
          title: Text('Dart基礎'),
          subtitle: Text('変数、計算、制御構文など'),
        ),
      ),
    );
  }
}