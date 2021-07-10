import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vreal/models/userr.dart';
import 'package:vreal/screens/authenticate/authenticate.dart';
import 'package:vreal/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
