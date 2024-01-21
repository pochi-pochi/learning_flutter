import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/DartBasic/BasicCaluculationWidget.dart';

class DartBasicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dart基礎講座')),
      body: ListView(
        children: <Widget>[
          BasicCaluculationWidget(),
        ],
      ),
    );
  }
}
