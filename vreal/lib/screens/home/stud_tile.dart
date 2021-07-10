import 'package:flutter/material.dart';
import 'package:vreal/models/student.dart';

class StudTile extends StatelessWidget {
  final Student student;
  StudTile({this.student});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            child: Text(student.roll),
          ),
          title: Text(student.name),
          subtitle: Text('Year ${student.year}'),
        ),
      ),
    );
  }
}
