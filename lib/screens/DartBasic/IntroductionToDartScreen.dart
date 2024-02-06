import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../services/complete_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntroductionToDartScreen extends StatefulWidget {
  @override
  _IntroductionToDartScreenState createState() => _IntroductionToDartScreenState();
}

class _IntroductionToDartScreenState extends State<IntroductionToDartScreen> {
  bool _isCourseCompleted = false; // 受講状況を追跡するフラグ

  @override
  void initState() {
    super.initState();
    _checkCourseCompletion('DartBasic_IntroductionToDart'); // 初期化時にコースの受講状況をチェック
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
                'Introduction to Dart',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(400, 30, 400, 0),
              child: IconButton(onPressed: ()=>launchUrlString('https://dart.dev/language'), icon: Icon(Icons.description))
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 0, 400, 0),
              child: Text(
                'ここからの内容は、dart公式ページの内容を和訳したものになります。対照ページは、上のボタンから参照してください。\n'
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 10, 400, 10),
              child: Text(
                '・Hello World\n'
                'すべてのアプリは実行を開始するためのトップレベルのmain関数が必要になります。明示的に値を返さない場合はvoidを返すようにします。\n'
                'コンソールにテキストを表示したい場合、トップレベルのprint関数を使うことができます。\n'
              ),
            ),
            // 受講状況に応じてボタンの表示を切り替え
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: ElevatedButton(
                onPressed: _isCourseCompleted ? null : () async{
                  await markCourseAsCompleted('DartBasic_IntroductionToDart');
                  await _checkCourseCompletion('DartBasic_IntroductionToDart');
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
