import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_flutter/screens/DartBasic/BasicCaluclationScreen.dart';

class BasicCalculationWidget extends StatefulWidget {
  @override
  _BasicCalculationWidgetState createState() => _BasicCalculationWidgetState();
}

class _BasicCalculationWidgetState extends State<BasicCalculationWidget> {
  bool _isCourseCompleted = false;

  @override
  void initState() {
    super.initState();
    // ここでコースIDを指定してください。例として"basicCalculationCourseId"を仮定します。
    _checkCourseCompletion("DartBasic_BasicCalculation");
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
          MaterialPageRoute(builder: (context) => BasicCaluculationScreen()),
        );
      },
      child: Card(
        child: ListTile(
          leading: _isCourseCompleted ? Icon(Icons.star, color: Colors.yellow) : null,
          title: Text('基本の計算'),
          subtitle: Text('四則演算、比較演算子'),
        ),
      ),
    );
  }
}
