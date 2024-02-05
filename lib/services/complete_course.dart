import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> markCourseAsCompleted(String courseId) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final userCourseRef = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('userCourse').doc(courseId);

    await userCourseRef.set({
      'finish': true,
    }, SetOptions(merge: true)); // ドキュメントが存在する場合はマージ
  }
}
