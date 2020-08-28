import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:appnewv1/screen_C/C_Conversation.dart';
import 'package:appnewv1/services/auth.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:appnewv1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:appnewv1/helpers/authenticate.dart';
import 'package:appnewv1/helpers/constants_login.dart';
import 'package:appnewv1/screen_C/C_UserSearch.dart';



class ChatRoom_try extends StatefulWidget {
  @override
  _ChatRoom_tryState createState() => _ChatRoom_tryState();
}

class _ChatRoom_tryState extends State<ChatRoom_try> {
  Stream ChatRoom;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: ChatRoom,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                userName: snapshot.data.documents[index].data['chatroomId']
                    .toString()
                    .replaceAll("_", "")
                    .replaceAll(Constants.myName, ""),
                chatroomId:
                snapshot.data.documents[index].data["chatroomId"],
              );
            })
            : Container();
      },
    );
  }

  AuthService authService = new AuthService();

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();

    databaseMethods.getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        ChatRoom = snapshots;
        print(
            "we got the data + ${ChatRoom.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  bool userIsLoggedIn;

  @override
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  void initState() {
    getUserInfogetChats();
    getLoggedInState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (userIsLoggedIn != null && userIsLoggedIn == true)
        ? Scaffold(
      body: Container(
        child: chatRoomsList(),
      ),
      /*Container(
              color: Colors.white,
              child:
                  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1000.0),
              ),
              Text("hello! " + Constants.myName,
                  style: TextStyle(
                      fontSize: 20.0,
                      height: 1.5,
                      color: appDeepBlueColor,
                      fontWeight: FontWeight.bold)),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
            ])
                  Container(
                child: chatRoomsList(),
              ),
            ),*/
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => search_chat()));
        },
      ),
    )
        : Scaffold(
      body: Container(

        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Image.asset(
              'assets/images/icons/pignojob.png',
              width: double.infinity,
            ),
            Text(
              "Please Login First",
              style:
              TextStyle(color: applightGreyColor, fontSize: 18),
            )
          ]),
        ),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatroomId;

  ChatRoomsTile({this.userName, @required this.chatroomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                    chatRoomId: chatroomId, friendname: userName)));
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(userName.substring(0, 1)),
              foregroundColor: Colors.white,
            ),
            title: Text(userName),
            subtitle: Text('last msg'),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              Firestore.instance
                  .collection('ChatRoom')
                  .document(chatroomId)
                  .delete();

              Firestore.instance
                  .collection('ChatRoom')
                  .document(chatroomId)
                  .collection("chats")
                  .getDocuments()
                  .then((snapshot) {
                for (DocumentSnapshot ds in snapshot.documents) {
                  ds.reference.delete();
                }
              });
            },
          ),
        ],
      ),

      /*Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [

            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),*/
    );
  }
}
