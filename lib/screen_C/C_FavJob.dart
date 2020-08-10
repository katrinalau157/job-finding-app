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

  void initState() {
    //saved.clear();
    getFavJobId();
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
      body: Center(
        child: (saved == null || saved == {} || saved.isEmpty)
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '沒有收藏打工',
              style: TextStyle(color: appGreyColor, fontSize: 20),
            ),
          ],
        )
            : StreamBuilder<QuerySnapshot>(
          stream:
          Firestore.instance.collection('JobPost').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                return new ListView(
                  children: snapshot.data.documents
                      .map((DocumentSnapshot document) {
                    //print(document.documentID);

                    return saved.contains(document.documentID)
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Card(
                          child: new Column(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                child: new ListTile(
                                  title: new Text(
                                    document["job_title"],
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: appDeepBlueColor),
                                    maxLines: 1,
                                  ),
                                  subtitle: new Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        new Text(
                                          document["company_name"],
                                          style: new TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal,
                                              height: 1.5),
                                          maxLines: 1,
                                        ),
                                        new Text(
                                          document["job_type"],
                                          style: new TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.normal,
                                              height: 1.5,
                                              color: Colors.blue[300]),
                                          maxLines: 1,
                                        ),
                                        new Text(
                                          document["job_location"],
                                          style: new TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.normal,
                                              height: 1.5,
                                              color: Colors.blue[300]),
                                          maxLines: 1,
                                        ),
                                      ]),
                                  trailing: Padding(
                                      padding:
                                      const EdgeInsets.all(
                                          0.0),
                                      child: favbutton(
                                          documentID:
                                          document.documentID,
                                          email: email)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => buildJobDetail(
                                            job_title: document[
                                            "job_title"],
                                            job_salary_type: document[
                                            "job_salary_type"],
                                            job_salary: document[
                                            "job_salary"],
                                            job_location: document[
                                            "job_location"],
                                            company_name: document[
                                            "company_name"],
                                            job_detail: document[
                                            "job_detail"],
                                            time:
                                            document["time"],
                                            lat: document["lat"],
                                            lng: document["lng"]),
                                      ),
                                    );

                                    //setState(() {});
                                  },
                                ),
                              )
                            ],
                          )),
                    )
                        : Container();
                  }).toList(),
                );
            }
          },
        ),
      ),
    )
        : Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1000.0),
            ),
            Text("Please Login first",
                style: TextStyle(
                    fontSize: 20.0,
                    height: 1.5,
                    color: appDeepBlueColor,
                    fontWeight: FontWeight.bold)),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
            ),
          ]),
    );
  }
}

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
