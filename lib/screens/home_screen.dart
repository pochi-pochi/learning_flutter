import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/DartBasicWidget.dart';
import 'package:learning_flutter/widgets/FlutterAdvanceWidget.dart';
import 'package:learning_flutter/widgets/FlutterBasicWidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('講座リスト',
      style: TextStyle(color: Colors.white, fontSize: 20),),
      backgroundColor: const Color.fromARGB(255, 52, 191, 216),),
      backgroundColor: Color.fromARGB(255, 146, 224, 238),
      body: ListView(
        children: <Widget>[
          DartBasicWidget(),
          FlutterBasicWidget(),
          FlutterAdvanceWidget(),
        ],
      ),
    );
  }
}
