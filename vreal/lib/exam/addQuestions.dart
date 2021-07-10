import 'package:flutter/material.dart';
import 'package:vreal/exam/quizData.dart';

class AddQuestions extends StatefulWidget {
  final String quizId;
  AddQuestions(this.quizId);

  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  final _formkey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  QuizData databaseService = new QuizData();

  uploadQuestionData() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      await databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Quiz"),
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(children: [
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Enter Question" : null,
                    decoration: InputDecoration(
                      hintText: "Question",
                    ),
                    onChanged: (val) {
                      question = val;
                    },
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Enter Option1" : null,
                    decoration: InputDecoration(
                      hintText: "Option1 (Correct Answer)",
                    ),
                    onChanged: (val) {
                      option1 = val;
                    },
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Enter Option2" : null,
                    decoration: InputDecoration(
                      hintText: "Option 2",
                    ),
                    onChanged: (val) {
                      option2 = val;
                    },
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Enter Option3" : null,
                    decoration: InputDecoration(
                      hintText: "Option 3",
                    ),
                    onChanged: (val) {
                      option3 = val;
                    },
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Enter Option4" : null,
                    decoration: InputDecoration(
                      hintText: "Option 4",
                    ),
                    onChanged: (val) {
                      option4 = val;
                    },
                  ),
                  Spacer(),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Submit'),
                        //style: ButtonStyle(),
                      ),
                      SizedBox(width: 24),
                      ElevatedButton(
                        onPressed: () {
                          uploadQuestionData();
                        },
                        child: Text('Add Question'),
                        //style: ButtonStyle(),
                      ),
                    ],
                  ),
                  SizedBox(height: 60)
                ]),
              ),
            ),
    );
  }
}
