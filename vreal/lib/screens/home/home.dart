import 'package:flutter/material.dart';
import 'package:vreal/exam/marks/emax_marks.dart';

import 'package:vreal/models/student.dart';
import 'package:vreal/exam/newHome.dart';
import 'package:vreal/exam/quiz.dart';
import 'package:vreal/screens/authenticate/fillinfo.dart';
import 'package:vreal/screens/home/grouphome.dart';
import 'package:vreal/screens/home/notes.dart';
import 'package:vreal/screens/home/notes/notespages.dart';
import 'package:vreal/screens/home/notes/shownotes.dart';
import 'package:vreal/screens/home/notice/notice.dart';
import 'package:vreal/screens/home/update.dart';
import 'package:vreal/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:vreal/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showUpPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: UpdateForm(),
            );
          });
    }

    return StreamProvider<List<Student>>.value(
      initialData: null,
      value: DatabaseService().students,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[800], elevation: 0,
            centerTitle: true,
            title: Text(
              "CVMS",
              style: TextStyle(
                  color: Colors.pinkAccent, fontWeight: FontWeight.bold),
            ),
            ////
            bottom: TabBar(
              indicatorColor: Colors.green,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.chat,
                    color: Colors.purple,
                  ),
                  text: "Chats",
                ),
                Tab(
                  icon: Icon(
                    Icons.event_note,
                    color: Colors.purple,
                  ),
                  text: "Notice",
                ),
                Tab(
                    icon: Icon(
                      Icons.article_rounded,
                      color: Colors.purple,
                    ),
                    text: "Notes"),
                Tab(
                  icon: Icon(
                    Icons.auto_stories,
                    color: Colors.purple,
                  ),
                  text: "Exam",
                ),
              ],
            ),
          ),

          drawer: Drawer(
              child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 40.0),
              Icon(Icons.account_circle, size: 150.0, color: Colors.grey[700]),
              SizedBox(height: 15.0),
              
              ListTile(
                //title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FillInfo()),
                  );
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.account_circle),
                title: Text('Profile', style: TextStyle(fontSize: 14)),
              ),

              ListTile(
                //title: Text('Notice',style: TextStyle(fontSize: 18),),
                onTap: () => _showUpPanel(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.event_note),
                title: Text('Notice', style: TextStyle(fontSize: 14)),
              ),

              ListTile(
                //title: Text('Notice',style: TextStyle(fontSize: 18),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExamMarks()),
                  );
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.note),
                title: Text('Marks', style: TextStyle(fontSize: 14)),
              ),

              ListTile(
                //title: Text('Log OUT'),
                onTap: () async {
                  await _auth.signOut();
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text('Log Out',
                    style: TextStyle(color: Colors.red, fontSize: 14)),
              ),
            ],
          )),
          body: TabBarView(
            children: [
              GroupHomePage(),
              NoticePage(),
              MainPage(),
              NewHome(),
              //ExamHomePage()
            ],
          ),
          //body: StudList()
        ),
      ),
    );
  }
}
