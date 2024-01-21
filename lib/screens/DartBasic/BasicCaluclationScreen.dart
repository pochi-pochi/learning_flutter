import 'package:flutter/material.dart';

class BasicCaluculationScreen extends StatefulWidget {
  @override
  _BasicCaluculationScreenState createState() => _BasicCaluculationScreenState();
}

class _BasicCaluculationScreenState extends State<BasicCaluculationScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _feedback = '';

  void _evaluateCode() {
    // ここにコード評価ロジックを実装
    String code = _codeController.text;
    bool hasTwoIntegers = RegExp(r'int\s+\w+\s*=\s*\d+;\s*int\s+\w+\s*=\s*\d+;').hasMatch(code);
    bool hasAddition = RegExp(r'print\(\s*\w+\s*\+\s*\w+\s*\)').hasMatch(code);
    setState(() {
      if (hasTwoIntegers && hasAddition) {
        _feedback = '正しいコードです！';
      } else {
        _feedback = 'コードが間違っています。もう一度試してください。';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本の計算'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // コンテンツの説明
            Text('dartでは、四則演算などの計算ができます。'),
            // コーディングテスト
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _codeController,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'コードを入力してください',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _evaluateCode,
              child: Text('コードを評価'),
            ),
            Text(_feedback),
          ],
        ),
      ),
    );
  }
}
