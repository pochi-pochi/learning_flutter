import 'package:flutter/material.dart';
import 'package:learning_flutter/screens/DartBasic/BasicCaluclationScreen.dart';


class BasicCaluculationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => BasicCaluculationScreen()),
        );
      },
      child: const Card(
        child: ListTile(
          title: Text('基本の計算'),
          subtitle: Text('四則演算、比較演算子'),
        ),
      ),
    );
  }
}