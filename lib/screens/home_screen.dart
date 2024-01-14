import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('講座リスト')),
      body: Center(child: Text('講座へのリンク'),),
    );
  }
}
