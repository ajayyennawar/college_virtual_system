// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoji_picker/emoji_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:vreal/screens/home/message_tile.dart';
// import 'package:vreal/services/database.dart';

// class GroupPage extends StatefulWidget {
//   final String groupId;
//   final String userName;
//   final String groupName;

//   GroupPage({
//     this.groupId,
//     this.userName,
//     this.groupName
//   });
//   @override
//   _GroupPageState createState() => _GroupPageState();
// }

// class _GroupPageState extends State<GroupPage> {
//    Stream<QuerySnapshot> _chats;
//   TextEditingController messageEditingController = new TextEditingController();
//   Widget _chatMessages(){
//     return StreamBuilder(
//       stream: _chats,
//       builder: (context, snapshot){
//         return snapshot.hasData ?  ListView.builder(
//           itemCount: snapshot.data.docs.length,
//           itemBuilder: (context, index){
//             return MessageTile(
//               message: snapshot.data.docs[index].data()["message"],
//               sender: snapshot.data.docs[index].data()["sender"],
//               sentByMe: widget.userName == snapshot.data.docs[index].data()["sender"],
//             );
//           }
//         )
//         :
//         Container();
//       },
//     );
//   }

//   _sendMessage() {
//     if (messageEditingController.text.isNotEmpty) {
//       Map<String, dynamic> chatMessageMap = {
//         "message": messageEditingController.text,
//         "sender": widget.userName,
//         'time': DateTime.now().millisecondsSinceEpoch,
//       };

//       DatabaseService().sendMessage(widget.groupId, chatMessageMap);

//       setState(() {
//         messageEditingController.text = "";
//       });
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     DatabaseService().getChats(widget.groupId).then((val) {
//       // print(val);
//       setState(() {
//         _chats = val;
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Text(widget.groupName, style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//         elevation: 0.0,
//       ),
//       body: Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: WillPopScope(
//               child: Stack(
//           children: [
//             _chatMessages(),
//             ListView(),
//             Align(
//               alignment: Alignment.bottomCenter,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width - 60,
//                         child: Card(
//                           margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           child: TextFormField(
//                             controller: messageEditingController,
//                             focusNode: focusNode,
//                             textAlignVertical: TextAlignVertical.center,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: 5,
//                             minLines: 1,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Type a message",
//                               prefixIcon: IconButton(
//                                 icon: Icon(
//                                   Icons.emoji_emotions,
//                                 ),
//                                 onPressed: () {
//                                   focusNode.unfocus();
//                                   focusNode.canRequestFocus = false;
//                                   setState((){
//                                     show = !show;
//                                   });
//                                 },
//                               ),
//                               suffixIcon: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(Icons.attach_file),
//                                     onPressed: () {
//                                       showModalBottomSheet(
//                                         backgroundColor: Colors.transparent,
//                                         context: context, builder: (builder) => bottomsheet());
//                                     },
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.send),
//                                     onPressed: () {
//                                       _sendMessage();
//                                     },
//                                   )
//                                 ],
//                               ),
//                              // contentPadding: EdgeInsets.all(5),
//                             ),
//                           )
//                           )),
//                       // Padding(
//                       //   padding: const EdgeInsets.only(bottom: 8, right: 5, left: 2),
//                         // child: CircleAvatar(
//                         //   radius: 25,
//                         //   backgroundColor: Color(0xFF128C7E),
//                         //   child: IconButton(
//                         //     icon: Icon(Icons.mic, color: Colors.white),
//                         //     onPressed: () {},
//                         //   )
//                         // ),
//                       //),
//                     ],
//               ),
//               show ? emojiSelect() : Container(),
//                   ],
//                 ),
//             )
//           ],
//         ),
//         // emoji popup
//         onWillPop: () {
//           if (show) {
//             setState((){
//               show = false;
//             });
//            }
//            else {
//               Navigator.pop(context);
//             }
//             return Future.value(false);
//         },
//       ),
//     ),

//   );
//   }

//   //files
//   Widget bottomsheet() {
//     return Container(
//       height: 160,
//       width: MediaQuery.of(context).size.width,
//       child: Card(
//         margin: EdgeInsets.all(18),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: (){
//                       print("okkk");
//                     },
//                     child: iconcreation(
//                       Icons.insert_drive_file, Colors.indigo, "Document"
//                       )
//                     ),

//                   SizedBox(width: 40),

//                   GestureDetector(
//                     onTap: (){
//                       print("bsdk");
//                     },
//                     child: iconcreation(Icons.camera_alt, Colors.pink, "Camera")
//                     ),

//                   SizedBox(width: 40),

//                   GestureDetector(
//                     onTap: (){},
//                     child: iconcreation(
//                       Icons.insert_photo, Colors.purple, "Gallery"
//                       )),

//               ],),

//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   //icons create
//   Widget iconcreation(IconData icons, Color color, String text){
//     return Column(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: color,
//             child: Icon(
//               icons,
//               size: 29,
//               color: Colors.white,
//             )
//           ),
//           SizedBox(height: 5,),
//           Text(text, style: TextStyle(
//             fontSize: 12,
//           ),),
//         ],

//     );
//   }

//   Widget emojiSelect() {

//     return EmojiPicker(
//       rows: 4,
//       columns: 7,
//       onEmojiSelected: (emoji, category) {
//       print(emoji);
//       messageEditingController.text = messageEditingController.text + emoji.emoji;
//     });
//   }
// }
