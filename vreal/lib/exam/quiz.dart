// import 'package:flutter/material.dart';
// import 'package:vreal/new/create_quiz.dart';
// import 'package:vreal/new/quizData.dart';

// class QuizHome extends StatefulWidget {
//   //const QuizHome({ Key? key }) : super(key: key);

//   @override
//   _QuizHomeState createState() => _QuizHomeState();
// }

// class _QuizHomeState extends State<QuizHome> {

//   Stream quizStream;
//   QuizData databaseService = new QuizData();

//   Widget quizList() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 24),
//       child: StreamBuilder(
//         stream: quizStream,
//         builder: (context, snapshot) {
//           return snapshot.data == null
//           ? Container():
//           ListView.builder(
//             itemCount: snapshot.data.docs.length,
//             itemBuilder: (context, index) {
//               return QuizTile(
//                 desc: snapshot.data.docs[index].data["quizdesc"],
//                 title: snapshot.data.docs[index].data["quiztitle"],
//                 time: snapshot.data.docs[index].data["quiztime"],
//               );
//             });
//         }
//       )
//     );
//   }

//   @override
//   void initState() {
//    databaseService.getQuizData().then((val) {
//      setState(() {
//        quizStream = val;
//      });
//    });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("quiz"),
//         backgroundColor: Colors.blue,
//         elevation: 0.0,
//         brightness: Brightness.light,
//       ),
//       body: quizList(),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Quiz(),
//               ));
//         },
//       ),
//     );
//   }
// }

// class QuizTile extends StatelessWidget {
//  final String title;
//  final String desc;
//  final String time;

//  QuizTile({
//    @required this.title,
//    @required this.desc,
//    @required this.time
//  });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 8),
//       height: 150,
//       child: Stack(
//         children: [
//           Container(
//             //alignment: Alignment.center,
//             child: Column(
//               //mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//               Text(title),
//               Text(desc),
//               Text(time)
//             ]),
//           )
//         ]
//       )

//     );
//   }
// }
