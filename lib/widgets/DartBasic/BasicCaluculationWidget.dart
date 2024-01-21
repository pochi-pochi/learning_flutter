import 'package:flutter/material.dart';


class BasicCaluculationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){

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