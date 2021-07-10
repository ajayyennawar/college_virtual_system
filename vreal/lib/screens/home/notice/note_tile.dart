import 'package:flutter/material.dart';
import 'package:vreal/models/student.dart';

class NoteTile extends StatelessWidget {
  final Notice notices;
  NoteTile({this.notices});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        //color: Colors.lightBlue[50],
        elevation: 15,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.0, left: 6.0, right: 6.0, bottom: 6.0),
          child: ExpansionTile(
            leading: Icon(
              Icons.notification_important,
              color: Colors.red,
            ),
            title: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Notice',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.red)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(notices.sub,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.green)),
                  ),
                  Text(notices.time)
                ],
              ),
            ),
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.lightGreen[200],
                    title: Text(
                      notices.describe,
                      style: TextStyle(color: Colors.black),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
