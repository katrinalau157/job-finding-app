import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:appnewv1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appnewv1/screen_C/C_ListJobDetail.dart';

//Set<String> saved = new Set<String>();
int selectedIndex = 0;
int clickindex = 0;

List tabs = ["地區", "時段", "篩選"];

bool abcd = false;

class C_listJob extends StatefulWidget {
  @override
  createState() {
    return _C_listJobState();
  }
}

class _C_listJobState extends State<C_listJob> {
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
    return getJobList_db();
  }
}

passdata() {
  return saved;
}

class getJobList_db extends StatefulWidget {
  @override
  _getJobList_dbState createState() => _getJobList_dbState();
}

class _getJobList_dbState extends State<getJobList_db> {
  @override
  OverlayEntry _overlayEntry1;
  OverlayState _overlay1;

  bool _isNT = false;
  bool _isHK = false;
  bool _isKL = false;
  bool _isButton1Disable = false;

  int abcindex = 1;

  void initState() {
    _overlay1 = Overlay.of(context);
  }

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ButtonBar(
          buttonMinWidth: (MediaQuery.of(context).size.width / 3) - 2,
          buttonPadding: EdgeInsets.all(0),
          children: [
            FlatButton.icon(
                label: Text(
                  "地區",
                  style: TextStyle(color: appDeepBlueColor),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: appDeepBlueColor,
                ),
                onPressed: () {
                  _isButton1Disable
                      ? {_isButton1Disable = false, _overlayEntry1.remove()}
                      : {
                    _overlayEntry1 = _createOverlayEntry1(),
                    _overlay1.insert(_overlayEntry1),
                    _isButton1Disable = true,
                  };
                }),
            Container(
              height: 40,
              child: VerticalDivider(),
              width: 1,
            ),
            FlatButton.icon(
              label: Text(
                "時段",
                style: TextStyle(color: appDeepBlueColor),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: appDeepBlueColor,
              ),
              onPressed: () => {},
            ),
            Container(
              height: 40,
              child: VerticalDivider(),
              width: 1,
            ),
            FlatButton.icon(
              label: Text(
                "篩選",
                style: TextStyle(color: appDeepBlueColor),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: appDeepBlueColor,
              ),
              onPressed: () => {},
            ),
            Container(
              height: 40,
              child: VerticalDivider(),
              width: 1,
            ),
          ],
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max),
      new Image.asset(
        'assets/images/icons/banner.png',
        width: double.infinity,
      ),
      Container(
        child: list_Jobpost(),
      )
    ]);
  }

  OverlayEntry _createOverlayEntry1() {
    return OverlayEntry(
        opaque: false,
        maintainState: false,
        builder: (context) => Positioned(
          //right: MediaQuery.of(context).size.width / 3,
            top: 125,
            width: MediaQuery.of(context).size.width / 3,
            height: 195,
            child: Material(
                elevation: 1.0,
                child: DefaultTabController(
                    length: 2,
                    child: new Container(
                        child: Scaffold(
                          body: getTab1Contents(),
                        ))))));
  }

  divider1() {
    return Divider(
      height: 1.0,
      thickness: 1,
    );
  }

  getTab1Contents() {
    return Column(children: <Widget>[
      Container(
        color: (_isNT ? Colors.grey[200] : Colors.white),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 10, right: 0),
          title: new Text('新界區'),
          onTap: () {
            _overlay1.setState(() {
              if (_isNT == false) {
                _isNT = true;
              } else {
                _isNT = false;
              }
            });
          },
          dense: true,
        ),
      ),
      divider1(),
      Container(
        color: (_isHK ? Colors.grey[200] : Colors.white),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 10, right: 0),
          title: new Text('港島區'),
          onTap: () {
            _overlay1.setState(() {
              if (_isHK == false) {
                _isHK = true;
                abcindex = 0;
              } else {
                _isHK = false;
                abcindex = 1;
              }
            });
          },
          dense: true,
        ),
      ),
      divider1(),
      Container(
        color: (_isKL ? Colors.grey[200] : Colors.white),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 10, right: 0),
          title: new Text('九龍區'),
          onTap: () {
            _overlay1.setState(() {
              if (_isKL == false) {
                _isKL = true;
              } else {
                _isKL = false;
              }
            });
          },
          dense: true,
        ),
      ),
      divider1(),
      ListTile(
        title: new Text('Done'),
        onTap: () => {
          _overlay1.setState(() {
            _isButton1Disable = false;
            _overlayEntry1.remove();
          }),
        },
        dense: true,
      ),
    ]);
  }
}

class list_Jobpost extends StatefulWidget {
  @override
  _list_JobpostState createState() => _list_JobpostState();
}

class _list_JobpostState extends State<list_Jobpost> {
  String email;
  void initState() {
    getLoggedInState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        email = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('JobPost').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
          print(snapshot.data.documents);
            return  Expanded(
              child: new ListView(
                children:
                snapshot.data.documents.map((DocumentSnapshot document) {
                  //print(document.documentID);
                  return Padding(
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
                                      fontWeight: FontWeight.bold,
                                      color: appDeepBlueColor),
                                  maxLines: 1,
                                ),
                                subtitle: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding: const EdgeInsets.all(0.0),
                                    child:
                                    /*IconButton(
                                  icon: (alreadySaved
                                      ? Icon(Icons.favorite)
                                      : Icon(Icons.favorite_border)),
                                  color: (alreadySaved
                                      ? appPinkColor
                                      : Colors.grey),
                                  onPressed: () {
                                    //DatabaseMethods().getUserInfo(email);

                                           print(email);
                                    Map<String, dynamic> favMap = {
                                      "fav": document.documentID,
                                    };
                                    //get user documentid
                                    DatabaseMethods().addUserFav(
                                        email, document.documentID, favMap);

                                    setState(() {
                                      if (alreadySaved) {
                                        saved.remove(document.documentID);
                                        //print("not favorit");
                                      } else {
                                        saved.add(document.documentID);
                                        //print("favorit");
                                      }
                                      print(saved);
                                    });
                                  })*/
                                    favbutton(
                                        documentID: document.documentID,
                                        email: email)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => buildJobDetail(
                                          job_title: document["job_title"],
                                          job_salary_type:
                                          document["job_salary_type"],
                                          job_salary: document["job_salary"],
                                          job_location: document["job_location"],
                                          company_name: document["company_name"],
                                          job_detail: document["job_detail"],
                                          time: document["time"],
                                          lat: document["lat"].toDouble(),
                                          lng: document["lng"].toDouble(),
                                        ),
                                      ));
                                  //setState(() {});
                                },
                              ),
                            )
                          ],
                        )),
                  );
                }).toList(),
              ),
            );
        }
      },
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
