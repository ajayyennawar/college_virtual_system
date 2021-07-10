import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vreal/models/student.dart';
import 'stud_tile.dart';

class StudList extends StatefulWidget {
  @override
  _StudListState createState() => _StudListState();
}

class _StudListState extends State<StudList> {
  @override
  Widget build(BuildContext context) {
    final students = Provider.of<List<Student>>(context) ?? [];
    // print(students.docs);

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return StudTile(student: students[index]);
      },
    );
  }
}
