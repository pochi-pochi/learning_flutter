import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/DartBasic/BasicCalculationWidget.dart';

class DartBasicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart基礎講座',
      style: TextStyle(color: Colors.white, fontSize: 20),),
      backgroundColor: const Color.fromARGB(255, 52, 191, 216),),
      backgroundColor: Color.fromARGB(255, 146, 224, 238),
      body: ListView(
        children: <Widget>[
          BasicCalculationWidget(),
        ],
      ),
    );
  }
}
