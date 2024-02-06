import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../services/complete_course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  bool _isCourseCompleted = false; // 受講状況を追跡するフラグ

  @override
  void initState() {
    super.initState();
    _checkCourseCompletion('DartBasic_Setup'); // 初期化時にコースの受講状況をチェック
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
                '環境構築',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(400, 30, 400, 0),
              child: IconButton(onPressed: ()=>launchUrlString('https://dart.dev/overview'), icon: Icon(Icons.car_crash))
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 0, 400, 0),
              child: Text(
                'dartは、プログラミング言語のひとつで、以下のような特徴があります。\n'
                '・UI用に最適化されている\n・生産性の高い開発ができる\n・すべてのプラットフォームで高速に動作する\n・オブジェクト指向を含むマルチパラダイム言語\n'
                '                                                                                        等\n',
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(400, 0, 400, 0),
              child: Text(
                'flutter SDKには、dart用のツールが同梱されているので、これを用いて環境開発を行います。\n'
                '下記のボタンからflutter SDKのページに飛べるので、ダウンロードした後、Cドライブ直下の「src」フォルダ内等に「flutter」フォルダを配置、パスを通してください。\n'
                'パスが通ったことを確認してください。\n',
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(400, 0, 400, 0),
              child: Center(
                child: Image.asset('images/check_version.png'),
              )
            ),
            // 受講状況に応じてボタンの表示を切り替え
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 30, 400, 30),
              child: ElevatedButton(
                onPressed: _isCourseCompleted ? null : () async{
                  await markCourseAsCompleted('DartBasic_Setup');
                  await _checkCourseCompletion('DartBasic_Setup');
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
