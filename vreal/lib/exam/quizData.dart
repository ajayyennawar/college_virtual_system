import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vreal/exam/question_model.dart';

final marksCollection = FirebaseFirestore.instance.collection('marks');

class QuizData {
  Future<void> addQuizData(Map quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getMcqData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }

  List<MarksEx> _marksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MarksEx(
        name: doc.data()['name'] ?? '',
        dept: doc.data()['dept'] ?? '0',
        year: doc.data()['year'] ?? '0',
        roll: doc.data()['roll'] ?? '',
        email: doc.data()['email'] ?? '',
        examName: doc.data()['examName'] ?? '',
        studmarks: doc.data()['studmarks'] ?? '',
      );
    }).toList();
  }

  Stream<List<MarksEx>> get marksShow {
    return marksCollection.snapshots().map(_marksListFromSnapshot);
  }
}
