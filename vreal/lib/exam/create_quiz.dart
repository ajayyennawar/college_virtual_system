import "package:flutter/material.dart";
import 'package:random_string/random_string.dart';
import 'package:vreal/exam/addQuestions.dart';
import 'package:vreal/exam/quizData.dart';
import 'package:vreal/services/database.dart';

class Quiz extends StatefulWidget {
  

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final _formkey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDesc, quizId, quizTime;
  QuizData _quizdata = new QuizData();
  DatabaseService dataServ = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quiztitle": quizTitle,
        "quizdesc": quizDesc,
        "quiztime": quizTime
      };
      await _quizdata.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestions(quizId)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" create quiz"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formkey,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                     
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter Quiz Title" : null,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.text_fields,
                          ),
                          hintText: "Quiz Title",
                        ),
                        onChanged: (val) {
                          quizTitle = val;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter Quiz Description" : null,
                        decoration: InputDecoration(
                          icon: Icon(Icons.note_add),
                          hintText: "Quiz Description",
                        ),
                        onChanged: (val) {
                          quizDesc = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Date & Time *',
                            icon: Icon(
                              Icons.timer_rounded,
                            ),
                            hintText: 'Enter Date & Time'),
                        validator: (val) =>
                            val.isEmpty ? 'enter Date & Time ' : null,
                        onChanged: (val) {
                          setState(() => quizTime = val);
                        },
                      ),
                      Spacer(),

                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          createQuizOnline();
                        },
                        child: Text('Create Test'),
                      ),
                      SizedBox(height: 100),
                    ],
                  )),
            ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

}
