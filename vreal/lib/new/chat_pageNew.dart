import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:vreal/newfiles/files.dart';
import 'package:vreal/services/database.dart';
import 'package:vreal/screens/home/message_tile.dart';

class ChatPageNew extends StatefulWidget {
  final String groupId;
  final String userName;
  final String groupName;

  ChatPageNew({this.groupId, this.userName, this.groupName});

  @override
  _ChatPageNewState createState() => _ChatPageNewState();
}

class _ChatPageNewState extends State<ChatPageNew> {
  bool show = false;
  FocusNode focusNode = FocusNode();

  Stream<QuerySnapshot> _chats;
  TextEditingController messageEditingController = new TextEditingController();
  ScrollController _scrollController = ScrollController();

  Widget _chatMessages() {
    return StreamBuilder(
      stream: _chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: MessageTile(
                      message: snapshot.data.docs[index].data()["message"],
                      sender: snapshot.data.docs[index].data()["sender"],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[index].data()["sender"],
                    ),
                  );
                })
            : Container();
      },
    );
  }

  _sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text,
        "sender": widget.userName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  //emoji picker focusNode
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    DatabaseService().getChats(widget.groupId).then((val) {
      // print(val);
      setState(() {
        _chats = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Stack(
            children: [
              _chatMessages(),
              ListView(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //height: 70,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width - 2,
                                child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      controller: messageEditingController,
                                      focusNode: focusNode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            Icons.emoji_emotions,
                                          ),
                                          onPressed: () {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            setState(() {
                                              show = !show;
                                            });
                                          },
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.attach_file),
                                              onPressed: () {
                                                Image_pick();
                                                
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.send),
                                              onPressed: () {
                                                _scrollController.animateTo(
                                                    _scrollController.position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeOut);
                                                _sendMessage();
                                              },
                                            )
                                          ],
                                        ),
                                        // contentPadding: EdgeInsets.all(5),
                                      ),
                                    ))),
                            
                          ],
                        ),
                        show ? emojiSelect() : Container(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          // emoji popup
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  //files
  Widget bottomsheet() {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        print("okkk");
                      },
                      child: iconcreation(
                          Icons.insert_drive_file, Colors.indigo, "Document")),
                  SizedBox(width: 40),
                  GestureDetector(
                      onTap: () {
                        print("bsdk");
                      },
                      child: iconcreation(
                          Icons.camera_alt, Colors.pink, "Camera")),
                  SizedBox(width: 40),
                  GestureDetector(
                      onTap: () {
                        Image_pick();
                      },
                      child: iconcreation(
                          Icons.insert_photo, Colors.purple, "Gallery")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //icons create
  Widget iconcreation(IconData icons, Color color, String text) {
    return Column(
      children: [
        CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              size: 29,
              color: Colors.white,
            )),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          messageEditingController.text =
              messageEditingController.text + emoji.emoji;
        });
  }
}
