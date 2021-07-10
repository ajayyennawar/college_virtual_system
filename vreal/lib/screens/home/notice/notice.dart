import 'package:flutter/material.dart';
import 'package:vreal/models/student.dart';
import 'package:vreal/screens/home/notice/notice_list.dart';
import 'package:provider/provider.dart';
import 'package:vreal/services/database.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Notice>>.value(
      initialData: null,
      value: DatabaseService().notice,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(child: NoticeList()),
      ),
    );
  }
}
