import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  FirebaseFile({
    this.ref,
    this.name,
    this.url,
  });
}
