import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vreal/models/student.dart';
import 'package:vreal/screens/home/notice/note_tile.dart';

class NoticeList extends StatefulWidget {
  @override
  _NoticeListState createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  @override
  Widget build(BuildContext context) {
    final notices = Provider.of<List<Notice>>(context) ?? [];
    // print(students.docs);

    return ListView.builder(
      itemCount: notices.length,
      itemBuilder: (context, index) {
        return NoteTile(notices: notices[index]);
      },
    );
  }
}
