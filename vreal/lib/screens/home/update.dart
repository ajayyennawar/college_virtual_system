import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vreal/models/userr.dart';
import 'package:vreal/services/database.dart';
import 'package:intl/intl.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> years = ['CSE', 'AI', 'CIVIL', 'ETC'];

  //values
  String _currentSub;
  String _currentDesc;
  String _notice;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd').add_jm();
  String _currentTime = formatter.format(now);
  // var crr = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);

    return StreamBuilder<NoticeData>(
        stream: DatabaseService(uid: user.uid).noticeData,
        builder: (context, snapshot) {
          NoticeData noticeData = snapshot.data;
          return Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Notice',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Notice ID'),
                    validator: (val) => val.isEmpty ? 'Enter Notice ID' : null,
                    onChanged: (val) => setState(() => _notice = val),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'subject/Topic'),
                    validator: (val) =>
                        val.isEmpty ? 'please enter Topic' : null,
                    onChanged: (val) => setState(() => _currentSub = val),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //note details
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 5, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Details of notice'),
                    validator: (val) =>
                        val.isEmpty ? 'please write here' : null,
                    onChanged: (val) => setState(() => _currentDesc = val),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  Row(
                    children: [
                      //Update or create
                      ElevatedButton(
                        child: Text('Save'),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            //  await DatabaseService(uid: user.uid).updateNotice
                            await DatabaseService(ye: _notice).updateNotice(
                                _currentSub ?? noticeData.sub,
                                _currentDesc ?? noticeData.describe,
                                _currentTime ?? noticeData.time);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      // delete
                      ElevatedButton(
                        child: Text('Delete'),
                        onPressed: () async {
                          
                          await DatabaseService(ye: _notice).deleteNotice();

                          Navigator.pop(context);
                          
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
