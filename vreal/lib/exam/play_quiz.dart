import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vreal/models/question_model.dart';
import 'package:vreal/exam/quizData.dart';
import 'package:vreal/exam/quiz_play_widget.dart';
import 'package:vreal/exam/result.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

class _PlayQuizState extends State<PlayQuiz> {
  QuizData databaseService = new QuizData();
  QuerySnapshot questionSnapshot;

  QuestionModel getQueModel(DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.data()["question"];

    List<String> options = [
      questionSnapshot.data()["option1"],
      questionSnapshot.data()["option2"],
      questionSnapshot.data()["option3"],
      questionSnapshot.data()["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data()["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getMcqData(widget.quizId).then((value) {
      questionSnapshot = value;
      _notAttempted = questionSnapshot.docs.length;
      _correct = 0;
      _incorrect = 0;
      total = questionSnapshot.docs.length;

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("quiz Test"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              questionSnapshot == null
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: questionSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        return QuizPlayTile(
                          questionModel:
                              getQueModel(questionSnapshot.docs[index]),
                          index: index,
                        );
                      }),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Results(
                              correct: _correct,
                              incorrect: _incorrect,
                              total: total)));
                },
                child: Text('Submit'),
                //style: ButtonStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Q${widget.index + 1} ${widget.questionModel.question}",
            style: TextStyle(fontSize: 17, color: Colors.black87)),
        SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              if (widget.questionModel.option1 ==
                  widget.questionModel.correctOption) {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                _incorrect = _incorrect + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: OptionTile(
            correctAnswer: widget.questionModel.correctOption,
            des: widget.questionModel.option1,
            option: "A",
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              if (widget.questionModel.option2 ==
                  widget.questionModel.correctOption) {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                _incorrect = _incorrect + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: OptionTile(
            correctAnswer: widget.questionModel.correctOption,
            des: widget.questionModel.option2,
            option: "B",
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              if (widget.questionModel.option3 ==
                  widget.questionModel.correctOption) {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                _incorrect = _incorrect + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: OptionTile(
            correctAnswer: widget.questionModel.correctOption,
            des: widget.questionModel.option3,
            option: "C",
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              if (widget.questionModel.option4 ==
                  widget.questionModel.correctOption) {
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                _incorrect = _incorrect + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: OptionTile(
            correctAnswer: widget.questionModel.correctOption,
            des: widget.questionModel.option4,
            option: "D",
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(height: 20)
      ]),
    );
  }
}
