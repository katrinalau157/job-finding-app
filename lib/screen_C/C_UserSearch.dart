import 'package:appnewv1/helpers/Constants.dart';
import 'package:appnewv1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:appnewv1/screen_C/C_Conversation.dart';
import 'package:appnewv1/helpers/constants_login.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';

class search_chat extends StatefulWidget {
  @override
  _search_chatState createState() => _search_chatState();
}

class _search_chatState extends State<search_chat> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  ///search
  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchResultSnapshot.documents.length,
        itemBuilder: (context, index) {
          return userTile(
            searchResultSnapshot.documents[index].data["name"],
            searchResultSnapshot.documents[index].data["email"],
          );
        })
        : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  createChatroomAndStartConversation(String userName) {
    if (userName != Constants.myName) {

      String chatroomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatroomId
      };
      databaseMethods.createChatRoom(chatRoomMap, chatroomId);

      //Navigator.pushReplacementNamed(context, ConversationScreen());
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId: chatroomId,friendname: userName,)));

    }
    else{
      print('you cannot send message to yourself');
    }
  }

  Widget userTile(String userName, String userEmail) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      //padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: new Card(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 60.0,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(color: appDeepBlueColor, fontSize: 16),
                  ),
                  Text(
                    userEmail,
                    style: TextStyle(color: appDeepBlueColor, fontSize: 16),
                  )
                ],
              ),
              Spacer(),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: appBlueColor)),
                child: Text(
                  "Message",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: appBlueColor,
                onPressed: () {
                  createChatroomAndStartConversation(userName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search trytry"),
        backgroundColor: appBlueColor,
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      decoration: InputDecoration(
                          hintText: "search username ...",
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      initiateSearch();
                    },
                    color: appGreenBlueColor,
                  ),
                ],
              ),
            ),
            userList()
          ],
        ),
      ),
    );
  }
}
