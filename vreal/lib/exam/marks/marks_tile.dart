import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vreal/exam/question_model.dart';

class MarksTile extends StatelessWidget {
  final MarksEx exmarks;
  MarksTile({this.exmarks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey[300],
        shadowColor: Colors.lightBlue[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        //color: Colors.lightBlue[50],
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.0, left: 6.0, right: 6.0, bottom: 6.0),
          child: ExpansionTile(
            leading:
                CircleAvatar(radius: 10.0, backgroundColor: Colors.lightBlue),
            title: Column(
              children: [
                Text('Exam - ${exmarks.examName}',
                    style:
                        GoogleFonts.yatraOne(fontSize: 18, color: Colors.red)),
                Text('Roll No. - ${exmarks.roll}')
              ],
            ),
            children: [
              Container(
                  width: 300,
                  color: Colors.lightBlue[200],
                  child: Column(
                    children: [
                      Text('Name - ${exmarks.name}'),
                      Text('Class - ${exmarks.dept} ${exmarks.year}'),
                      Text('Marks Obtained - ${exmarks.studmarks}'),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
