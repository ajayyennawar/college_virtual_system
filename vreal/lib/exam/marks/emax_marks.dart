import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vreal/exam/marks/markslist.dart';
import 'package:vreal/exam/question_model.dart';
import 'package:vreal/exam/quizData.dart';

class ExamMarks extends StatefulWidget {
  @override
  _ExamMarksState createState() => _ExamMarksState();
}

class _ExamMarksState extends State<ExamMarks> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MarksEx>>.value(
        initialData: null,
        value: QuizData().marksShow,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            child: Column(
              children: [
                Container(height: 560, child: Hlist()),
              ],
            ),
          ),
        ));
  }
}
