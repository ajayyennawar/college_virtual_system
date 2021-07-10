import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vreal/models/userr.dart';
import 'package:vreal/services/database.dart';

class FillInfo extends StatefulWidget {
  @override
  _FillInfoState createState() => _FillInfoState();
}

final _formkey = GlobalKey<FormState>();
final List<String> years = ['CSE', 'AI', 'CIVIL', 'ETC'];

//values
String _currentName;
String _currentDept;

class _FillInfoState extends State<FillInfo> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);

    return Scaffold(
      body: StreamBuilder<UserDataT>(
          stream: DatabaseService(uid: user.uid).userDataT,
          builder: (context, snapshot) {
            UserDataT userDataT = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    'Update your Information',
                    style: TextStyle(fontSize: 18),
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
                        hintText: 'Name'),
                    validator: (val) =>
                        val.isEmpty ? 'please enter name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //drop down
                  DropdownButtonFormField(
                    items: years.map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text('$year'),
                      );
                    }).toList(),
                    validator: (val) => val.isEmpty ? 'please select' : null,
                    onChanged: (val) => setState(() => _currentDept = val),
                  ),
                  //slider

                  SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                    child: Text('Save'),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserDataT(
                            _currentName ?? userDataT.name,
                            _currentDept ?? userDataT.dept,
                            'hfoiahfo');
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}
