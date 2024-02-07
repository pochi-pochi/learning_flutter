import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../services/complete_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VariablesScreen extends StatefulWidget {
  @override
  _VariablesScreenState createState() => _VariablesScreenState();
}

class _VariablesScreenState extends State<VariablesScreen> {
  bool _isCourseCompleted = false; // 受講状況を追跡するフラグ

  @override
  void initState() {
    super.initState();
    _checkCourseCompletion('DartBasic_Variables'); // 初期化時にコースの受講状況をチェック
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
        title: const Text('Variables',
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
                'Variables',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(400, 30, 400, 0),
              child: IconButton(onPressed: ()=>launchUrlString('https://dart.dev/language/variables'), icon: Icon(Icons.description))
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 10, 400, 0),
              child: Text(
                'ここでは、変数を定義して、それを初期化する例を示します。\n'
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 0, 400, 10),
              child: SelectableText(
                '''var name = 'Bob';''',
                style: TextStyle(
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 0, 400, 0),
              child: Text(
                '変数には、参照が格納されます。変数nameが呼び出されると、"Bob"が格納されたString型のオブジェクトが参照されます。\n'
                '変数nameの型はString型だと推測されますが、型を指定して変更することもできます。そのオブジェクトが一つの型に制限されていない場合、'
                'オブジェクトタイプを指定できます（もしくは、動的に変更できます）。\n'
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 0, 400, 0),
              child: SelectableText(
                '''Object name = 'Bob';'''
                '\n\n別のオプションとして、予測される方を明示的に宣言することもできます。\n\n'
                '''String name = 'Bob';''',
                style: TextStyle(
                  fontFamily: 'monospace',
                ),
              ),
            ),

            // Null Safety
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 0, 400, 0),
              child: Text(
                '・Null safety\n'
                'Dart言語は、健全なNull安全性を実行します。\n\n'
                'Null安全性は、nullに設定された変数への意図しないアクセスに起因するエラーを防止します。このエラーは、null逆参照エラーと呼ばれます。'
                'このエラーは、nullと評価されるプロパティやメソッドへのアクセスを行うことで発生します。'
              ),
            ),

            // 受講状況に応じてボタンの表示を切り替え
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: ElevatedButton(
                onPressed: _isCourseCompleted ? null : () async{
                  await markCourseAsCompleted('DartBasic_Variables');
                  await _checkCourseCompletion('DartBasic_Variables');
                } ,
                child: Text(_isCourseCompleted ? '受講完了！' : '受講済みにする'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
