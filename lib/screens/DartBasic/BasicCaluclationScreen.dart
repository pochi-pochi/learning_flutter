import 'package:flutter/material.dart';
import '../../services/complete_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BasicCaluculationScreen extends StatefulWidget {
  @override
  _BasicCaluculationScreenState createState() => _BasicCaluculationScreenState();
}

class _BasicCaluculationScreenState extends State<BasicCaluculationScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _feedback = '';
  bool _isCourseCompleted = false; // 受講状況を追跡するフラグ

  @override
  void initState() {
    super.initState();
    _checkCourseCompletion('DartBasic_BasicCalculation'); // 初期化時にコースの受講状況をチェック
  }

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

  Future<void> _checkCourseCompletion(String courseId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userCourseRef = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('userCourse').doc(courseId);
      try {
        final snapshot = await userCourseRef.get();
        final isCompleted = snapshot.exists && snapshot.data()?['finish'] == true;
        // UIを更新するためにsetStateを使用
        setState(() {
          _isCourseCompleted = isCompleted;
        });
      } catch (e) {
        print("エラーが発生しました: $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基本の計算',
        style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: const Color.fromARGB(255, 52, 191, 216),
      ),
      backgroundColor: const Color.fromARGB(255, 146, 224, 238),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ここから説明
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: Text(
                'Dartでの四則演算',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: Text(
                'Dartでは、他の言語と同様に、四則演算などの基本的な演算ができます。\n'
                '演算子としては、加算の「+」、減算の「-」、乗算の「*」、割り算の「/」等があります。',
              ),
            ),
            // 受講状況に応じてボタンの表示を切り替え
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: ElevatedButton(
                onPressed: _isCourseCompleted ? null : () async{
                  await markCourseAsCompleted('DartBasic_BasicCalculation');
                  await _checkCourseCompletion('DartBasic_BasicCalculation');
                } ,
                child: Text(_isCourseCompleted ? '受講完了！' : '受講済みにする'),
              ),
            ),


            // コーディングテスト
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: TextField(
                controller: _codeController,
                maxLines: 8,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'コードを入力してください',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: ElevatedButton(
                onPressed: _evaluateCode,
                child: const Text('コードを評価'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: Text(_feedback),
            ),
          ],
        ),
      ),
    );
  }
}
