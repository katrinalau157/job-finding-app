import 'dart:io';

import 'package:appnewv1/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:appnewv1/helpers/Constants.dart';
import 'package:appnewv1/helpers/constants_login.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';
//import 'package:image_picker/image_picker.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String friendname;
  ConversationScreen({this.chatRoomId,this.friendname});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }

  @override
  void initState() {
    getUserInfo();
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return MessageTile(
                message: snapshot.data.documents[index].data["message"],
                sendByMe: Constants.myName ==
                    snapshot.data.documents[index].data["sendBy"],
              );
            })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.friendname),
        backgroundColor: appBlueColor,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(child: chatMessages())),
            Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child:buildInput(context)
              /*Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageEditingController,
                      decoration: InputDecoration(
                          hintText: "有問題嗎？問看看吧！",
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                          border: InputBorder.none),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      color: appWhiteColor,
                      onPressed: () {
                        addMessage();
                      },
                    ),
                  ],
                ),
              ),*/
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: (){},
                color: appBlueColor,

              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.insert_emoticon),
                onPressed: (){},
                color: appBlueColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                controller: messageEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: "有問題嗎？問看看吧！",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  addMessage();
                },
                color: appBlueColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height/11,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300], width: 0.5)), color: Colors.white),
    );
  }

}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin:
          sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: sendByMe
                  ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
                  : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
              gradient: LinearGradient(
                colors: sendByMe
                    ? [appMintColor, appMintColor]
                    : [Colors.grey[350], Colors.grey[350]],
              )),
          child: Text(message,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300)),
        ),
      ),
    );
  }
}
