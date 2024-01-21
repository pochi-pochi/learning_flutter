import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/DartBasicWidget.dart';
import 'package:learning_flutter/widgets/FlutterAdvanceWidget.dart';
import 'package:learning_flutter/widgets/FlutterBasicWidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('講座リスト')),
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
