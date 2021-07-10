import 'package:firebase_auth/firebase_auth.dart';
import 'package:vreal/models/userr.dart';
import 'package:vreal/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user object

  Userr _userFromUser(User user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<Userr> get user {
    return _auth
        .authStateChanges()
        //.map((User user) => _userFromUser(user));
        .map(_userFromUser);
  }

//singin email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register email
  Future registerWithEmailAndPassword(
      String email, String password, String n, String d, String e) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create new document for user with uid
      await DatabaseService(uid: user.uid).updateUserDataT(n, d, e);
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset pass
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

//singout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
