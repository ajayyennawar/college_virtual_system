import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vreal/exam/marks/marks_tile.dart';
import 'package:vreal/exam/question_model.dart';

class Hlist extends StatefulWidget {
  @override
  _HlistState createState() => _HlistState();
}

class _HlistState extends State<Hlist> {
  @override
  Widget build(BuildContext context) {
    final plas = Provider.of<List<MarksEx>>(context) ?? [];
    // print(students.docs);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: plas.length,
      itemBuilder: (context, index) {
        return MarksTile(exmarks: plas[index]);
      },
    );
  }
}
