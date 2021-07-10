import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vreal/models/userr.dart';
import 'package:vreal/screens/wrapper.dart';
import 'package:vreal/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userr>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light, primaryColor: Colors.blueGrey),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        //home: LoginPageNew(),
      ),
    );
  }
}
