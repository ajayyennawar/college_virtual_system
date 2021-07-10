import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vreal/helper/helperfunction.dart';
import 'package:vreal/screens/authenticate/forget_pass.dart';
import 'package:vreal/services/auth.dart';
import 'package:vreal/services/database.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //textfield state

  String email = '';
  String password = '';
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'enter email ' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          hintText: 'Password'),
                      obscureText: true,
                      validator: (val) =>
                          val.length < 8 ? 'Enter password 8 charecter' : null,
                      onChanged: (val) {
                        //setState(()=> email = val);
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text(
                        'LogIn',
                        style: TextStyle(color: Colors.white),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepOrange),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password)
                              .then((result) async {
                            if (result != null) {
                              QuerySnapshot userInfoSnapshot =
                                  await DatabaseService().getUserData(email);
                              await HelperFunctions
                                  .saveUserEmailSharedPreference(email);
                              await HelperFunctions
                                  .saveUserNameSharedPreference(
                                      userInfoSnapshot.docs[0].data()['name']);
                              await HelperFunctions
                                      .getUserEmailSharedPreference()
                                  .then((value) {});
                              await HelperFunctions
                                      .getUserNameSharedPreference()
                                  .then((value) {});
                            }
                          });
                          if (result == null) {
                            setState(() => error = 'Invalid Credentials');
                          }
                        }
                      },
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Reset()));
                          },
                          child: Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    TextButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text('Register here'))
                  ],
                ))),
      ),
    );
  }
}
