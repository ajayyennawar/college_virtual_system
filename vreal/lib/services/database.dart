import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vreal/models/student.dart';
import 'package:vreal/models/userr.dart';

class DatabaseService {
  final String uid;
  final String ye;

  DatabaseService({this.uid, this.ye});

  //collection refrence
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('students');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');
  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('teachers');
  final CollectionReference noticeCollection =
      FirebaseFirestore.instance.collection('Notices');

  ///teacher
  Future updateUserDataT(String name, String dept, String email) async {
    return await teacherCollection.doc(uid).set({
      'name': name,
      'dept': dept,
      'email': email,
      'groups': [],
      'profile': ''
    });
  }

////////////////Group DB///////////////\
  ///
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // create group
  Future createGroup(String userName, String groupName) async {
    DocumentReference groupDocRef = await groupCollection.add({
      'groupName': groupName,
      'groupIcon': '',
      'admin': userName,
      'members': [],
      //'messages': ,
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': ''
    });

    await groupDocRef.update({
      'members': FieldValue.arrayUnion([uid + '_' + userName]),
      'groupId': groupDocRef.id
    });

    DocumentReference userDocRef = teacherCollection.doc(uid);
    return await userDocRef.update({
      'groups': FieldValue.arrayUnion([groupDocRef.id + '_' + groupName])
    });
  }

  // toggling the user group join
  Future togglingGroupJoin(
      String groupId, String groupName, String userName) async {
    DocumentReference userDocRef = teacherCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference groupDocRef = groupCollection.doc(groupId);

    List<dynamic> groups = await userDocSnapshot.data()['groups'];

    if (groups.contains(groupId + '_' + groupName)) {
      //print('hey');
      await userDocRef.update({
        'groups': FieldValue.arrayRemove([groupId + '_' + groupName])
      });

      await groupDocRef.update({
        'members': FieldValue.arrayRemove([uid + '_' + userName])
      });
    } else {
      //print('nay');
      await userDocRef.update({
        'groups': FieldValue.arrayUnion([groupId + '_' + groupName])
      });

      await groupDocRef.update({
        'members': FieldValue.arrayUnion([uid + '_' + userName])
      });
    }
  }

  // has user joined the group
  Future<bool> isUserJoined(
      String groupId, String groupName, String userName) async {
    DocumentReference userDocRef = teacherCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    List<dynamic> groups = await userDocSnapshot.data()['groups'];

    if (groups.contains(groupId + '_' + groupName)) {
      //print('he');
      return true;
    } else {
      //print('ne');
      return false;
    }
  }

  // get user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await teacherCollection.where('email', isEqualTo: email).get();
    print(snapshot.docs[0].data);
    return snapshot;
  }

  // get user groups
  getUserGroups() async {
    // return await Firestore.instance.collection("users").where('email', isEqualTo: email).snapshots();
    return FirebaseFirestore.instance
        .collection("teachers")
        .doc(uid)
        .snapshots();
  }

  // send message
  sendMessage(String groupId, chatMessageData) {
    FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .add(chatMessageData);
    FirebaseFirestore.instance.collection('groups').doc(groupId).update({
      'recentMessage': chatMessageData['message'],
      'recentMessageSender': chatMessageData['sender'],
      'recentMessageTime': chatMessageData['time'].toString(),
    });
  }

  // get chats of a particular group
  getChats(String groupId) async {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  // search groups
  searchByName(String groupName) {
    return FirebaseFirestore.instance
        .collection("groups")
        .where('groupName', isEqualTo: groupName)
        .get();
  }
//////////////////////////////////////////////////////////////////////////////////////end///////////////////////////////////////////////////////////
  ///notice Update

  Future updateNotice(String sub, String describe, String time) async {
    return await noticeCollection
        .doc(ye)
        .set({'sub': sub, 'describe': describe, 'time': time});
  }

  Future deleteNotice() async {
    return await noticeCollection.doc(ye).delete();
  }

  ///end here
  List<Student> _studentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Student(
        name: doc.data()['name'] ?? '',
        roll: doc.data()['roll'] ?? '0',
        year: doc.data()['year'] ?? '0',
      );
    }).toList();
  }

  ///ihgdfoiuagfag
  List<Notice> _noticeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Notice(
          sub: doc.data()['sub'] ?? '',
          describe: doc.data()['describe'] ?? '0',
          time: doc.data()['time'] ?? '0');
    }).toList();
  }
  //userdata from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        roll: snapshot.data()['roll'],
        year: snapshot.data()['year']);
  }

  //teacher data
  UserDataT _userDataFromSnapshotT(DocumentSnapshot snapshot) {
    return UserDataT(
      uid: uid,
      name: snapshot.data()['name'],
      dept: snapshot.data()['dept'],
    );
  }

  //notice data
  NoticeData _noticeDatasnap(DocumentSnapshot snapshot) {
    return NoticeData(
        uid: uid,
        sub: snapshot.data()['sub'],
        describe: snapshot.data()['describe'],
        time: snapshot.data()['time']);
  }

  Stream<List<Student>> get students {
    return studentCollection
        .orderBy('roll')
        .snapshots()
        .map(_studentListFromSnapshot);
  }

  ///notice list
  Stream<List<Notice>> get notice {
    return noticeCollection.snapshots().map(_noticeListFromSnapshot);
  }

//get user doc steram
  Stream<UserData> get userData {
    return studentCollection.doc().snapshots().map(_userDataFromSnapshot);
  }

  //get user teacher doc steram
  Stream<UserDataT> get userDataT {
    return teacherCollection.doc().snapshots().map(_userDataFromSnapshotT);
  }

  //gget notice dta
  Stream<NoticeData> get noticeData {
    return noticeCollection.doc().snapshots().map(_noticeDatasnap);
  }
}
