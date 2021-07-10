import 'package:flutter/material.dart';
import 'package:vreal/exam/create_quiz.dart';
import 'package:vreal/exam/play_quiz.dart';
import 'package:vreal/exam/quizData.dart';

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  Stream quizStream;
  QuizData databaseService = new QuizData();

  Widget quizList() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder(
          stream: quizStream,
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return QuizTile(
                        title: snapshot.data.docs[index].data()["quiztitle"],
                        desc: snapshot.data.docs[index].data()["quizdesc"],
                        time: snapshot.data.docs[index].data()["quiztime"],
                        quizId: snapshot.data.docs[index].data()["quizId"],
                      );
                    });
          },
        ));
  }

  @override
  void initState() {
    databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Quiz(),
              ));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String title;
  final String desc;
  final String time;
  final String quizId;

  QuizTile({this.title, this.desc, this.time, this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayQuiz(quizId),
            ));
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.teal[100],
          ),
          margin: EdgeInsets.only(bottom: 8),
          height: 150,
          width: MediaQuery.of(context).size.width - 48,
          child: Stack(children: [
            Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(height: 6),
                    Text(desc,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple)),
                    SizedBox(height: 6),
                    Text(time,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red)),
                  ],
                ))
          ])),
    );
  }
}
