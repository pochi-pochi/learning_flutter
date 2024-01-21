import 'package:flutter/material.dart';


class FlutterBasicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){

      },
      child: const Card(
        child: ListTile(
          title: Text('Flutter基礎'),
          subtitle: Text('Widgetなど'),
        ),
      ),
    );
  }
}