import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_flutter/screens/DartBasic/SetupScreen.dart';

class SetupWidget extends StatefulWidget {
  @override
  _SetupWidgetState createState() => _SetupWidgetState();
}

class _SetupWidgetState extends State<SetupWidget> {
  bool _isCourseCompleted = false;

  @override
  void initState() {
    super.initState();
    _checkCourseCompletion("DartBasic_Setup");
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
          MaterialPageRoute(builder: (context) => SetupScreen()),
        );
      },
      child: Card(
        child: ListTile(
          leading: _isCourseCompleted ? Icon(Icons.star, color: Colors.yellow) : null,
          title: Text('環境構築'),
          subtitle: Text('Flutter/dartの環境構築'),
        ),
      ),
    );
  }
}
