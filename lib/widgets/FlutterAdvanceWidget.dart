import 'package:flutter/material.dart';


class FlutterAdvanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){

      },
      child: const Card(
        child: ListTile(
          title: Text('Flutter応用'),
          subtitle: Text('Firebaseとの連携、APIの活用など'),
        ),
      ),
    );
  }
}