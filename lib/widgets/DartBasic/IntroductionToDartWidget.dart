import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_flutter/screens/DartBasic/IntroductionToDartScreen.dart';

class IntroductionToDartWidget extends StatefulWidget {
  @override
  _IntroductionToDartWidgetState createState() => _IntroductionToDartWidgetState();
}

class _IntroductionToDartWidgetState extends State<IntroductionToDartWidget> {
  bool _isCourseCompleted = false;

  @override
  void initState() {
    super.initState();
    _checkCourseCompletion("DartBasic_IntroductionToDart");
  }

  Future<void> _checkCourseCompletion(String courseId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userCourseRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('userCourse')
          .doc(courseId);
      try {
        final snapshot = await userCourseRef.get();
        final isCompleted = snapshot.exists && snapshot.data()?['finish'] == true;
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => IntroductionToDartScreen()),
        );
      },
      child: Card(
        child: ListTile(
          leading: _isCourseCompleted ? Icon(Icons.star, color: Colors.yellow) : null,
          title: Text('Introduction to Dart'),
          subtitle: Text('dartの基本的な内容の説明'),
        ),
      ),
    );
  }
}
