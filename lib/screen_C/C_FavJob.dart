import 'package:appnewv1/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appnewv1/screen_C/C_ListJobDetail.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';

class W_Body_favJob_C extends StatefulWidget {
  @override
  _W_Body_favJob_CState createState() {
    return _W_Body_favJob_CState();
  }
}

class _W_Body_favJob_CState extends State<W_Body_favJob_C> {
  String email;
/*

  getFavJobId() async {
    if (userIsLoggedIn == true) {
      await HelperFunctions.getUserEmailSharedPreference().then((value) {
        setState(() {
          email = value.toString();
          var result = Firestore.instance
              .collection("users")
              .where("email", isEqualTo: email)
              .getDocuments()
              .then((querySnapshot) {
            querySnapshot.documents.forEach((value) {
              Firestore.instance
                  .collection("users")
                  .document(value.documentID)
                  .collection("fav")
                  .getDocuments()
                  .then((querySnapshot) {
                querySnapshot.documents.forEach((result) {
                  saved.add(result.data["fav"]);
                });
              });
            });
          });
        });
      });
    }
  }
*/

  void initState() {
    //saved.clear();
    //getFavJobId();
    getLoggedInState();
    //print(email);
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
  Widget build(BuildContext context) {
    return (userIsLoggedIn != null && userIsLoggedIn == true)
        ? Scaffold(
            backgroundColor: appWhiteColor,
            body: (saved == null || saved == {} || saved.isEmpty)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '沒有收藏打工',
                          style: TextStyle(color: appGreyColor, fontSize: 20),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: saved
                          .map(
                            (element) => Card(
                              child: new Column(
                                children: <Widget>[
                                  Container(
                                      height: 100.0,
                                      child: new ListTile(
                                          title: new Text(
                                            globalJobList[element][1],
                                            style: new TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: appDeepBlueColor),
                                            maxLines: 1,
                                          ),
                                          subtitle: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  globalJobList[element][0],
                                                  style: new TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height: 1.5),
                                                  maxLines: 1,
                                                ),
                                                new Text(
                                                  globalJobList[element][2],
                                                  style: new TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height: 1.5,
                                                      color: Colors.blue[300]),
                                                  maxLines: 1,
                                                ),
                                                new Text(
                                                  globalJobList[element][4] +
                                                      " " +
                                                      globalJobList[element]
                                                          [10],
                                                  style: new TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height: 1.5,
                                                      color: Colors.blue[300]),
                                                  maxLines: 1,
                                                ),
                                              ]),
                                          trailing: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: favbutton(
                                                index: element),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      buildJobDetail(
                                                          job_title: globalJobList[element][1],
                                                          job_salary_type:
                                                          globalJobList[element][4],
                                                          job_salary:
                                                          globalJobList[element][10],
                                                          job_location:
                                                          globalJobList[element][5],
                                                          company_name:
                                                          globalJobList[element][0],
                                                          job_detail:
                                                          globalJobList[element][3],
                                                          time: globalJobList[element][6],
                                                          lat: double.parse(
                                                              globalJobList[element][8]),
                                                          lng: double.parse(
                                                              globalJobList[element][9]),
                                                          email: globalJobList[element][7],
                                                          username_db:
                                                          globalJobList[element][13],
                                                          timerange:
                                                          globalJobList[element][12]),
                                                ));
                                            //setState(() {});
                                          }))
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
          )
        : Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: appWhiteColor,
              body: Center(
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
/*

class favbutton extends StatefulWidget {
  final String documentID;
  final String email;
  favbutton({this.documentID, this.email});

  @override
  _favbuttonState createState() => _favbuttonState();
}

class _favbuttonState extends State<favbutton> {
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    // TODO: implement initState
    super.initState();
  }

  @override
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final alreadySaved = saved.contains(widget.documentID);
    return IconButton(
        icon: ((alreadySaved && userIsLoggedIn == true)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border)),
        color: ((alreadySaved && userIsLoggedIn == true)
            ? appPinkColor
            : Colors.grey),
        onPressed: () {
          setState(() {
            if (alreadySaved && userIsLoggedIn == true) {
              saved.remove(widget.documentID);
              //print("not favorit");
              DatabaseMethods().deleteUserFav(widget.email, widget.documentID);
            }
            if (alreadySaved == false && userIsLoggedIn == true) {
              saved.add(widget.documentID);
              //print("favorit");
              Map<String, dynamic> favMap = {
                "fav": widget.documentID,
              };
              //get user documentid
              DatabaseMethods()
                  .addUserFav(widget.email, widget.documentID, favMap);
            }
            if (userIsLoggedIn == false) {
              Navigator.of(context).pushNamed(C_loginTag);
            } else {}
            print(saved);
          });
        });
  }
}
*/

class favbutton extends StatefulWidget {
//  final String documentID;
//  final String email;
//  favbutton({this.documentID, this.email});

  final int index;
  favbutton(
      { this.index});
  @override
  _favbuttonState createState() => _favbuttonState();
}

class _favbuttonState extends State<favbutton> {
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    // TODO: implement initState
    super.initState();
  }

  @override
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int savedid = widget.index;
    final alreadySaved = saved.contains(savedid);
    return IconButton(
        alignment: Alignment(3, -3.5),
        icon: ((alreadySaved && userIsLoggedIn == true)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border)),
        color: ((alreadySaved && userIsLoggedIn == true)
            ? appPinkColor
            : Colors.grey),
        onPressed: () {
          setState(() {
            if (alreadySaved == true && userIsLoggedIn == true) {
              saved.remove(savedid);
              print(globalJobList[widget.index]);

              if (saved.isEmpty) {
                savedJoblist.clear();
              }
              //savedJoblist = Set<List>();
              //print("not favorit");
//              DatabaseMethods().deleteUserFav(widget.email, widget.documentID);
            }
            if (alreadySaved == false && userIsLoggedIn == true) {
              globalJobList.add(widget.index);
              saved.add(savedid);
              //print("favorit");
/*              Map<String, dynamic> favMap = {
          "fav": widget.documentID,
        };
        //get user documentid
        DatabaseMethods()
            .addUserFav(widget.email, widget.documentID, favMap);*/
            }
            if (userIsLoggedIn == false) {
              Navigator.of(context).pushNamed(C_loginTag);
            } else {}
            //print(savedJoblist);
            //print(saved);
            print(widget.index);
          });
        });
  }
}
