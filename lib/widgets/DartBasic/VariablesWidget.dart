import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_flutter/screens/DartBasic/VariablesScreen.dart';

class VariablesWidget extends StatefulWidget {
  @override
  _VariablesWidgetState createState() => _VariablesWidgetState();
}

class _VariablesWidgetState extends State<VariablesWidget> {
  bool _isCourseCompleted = false;

  @override
  void initState() {
    super.initState();
    _checkCourseCompletion("DartBasic_Variables");
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
          MaterialPageRoute(builder: (context) => VariablesScreen()),
        );
      },
      child: Card(
        child: ListTile(
          leading: _isCourseCompleted ? Icon(Icons.star, color: Colors.yellow) : null,
          title: Text('Variables'),
          subtitle: Text('変数やその初期化'),
        ),
      ),
    );
  }
}
