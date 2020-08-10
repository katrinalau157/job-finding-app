import 'package:appnewv1/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:appnewv1/screen_C/C_ListJobDetail.dart';
import 'package:appnewv1/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class W_Body_listJob_B extends StatefulWidget {
  @override
  _W_Body_listJob_BState createState() {
    return _W_Body_listJob_BState();
  }
}

class _W_Body_listJob_BState extends State<W_Body_listJob_B> {
  String email;
  bool userIsLoggedIn;

  @override
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  getEmailInState() async {
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        email = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getEmailInState();
    getLoggedInState();
    super.initState();
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("JobPost")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return (userIsLoggedIn != null && userIsLoggedIn == true)
        ? Scaffold(
            body: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('JobPost')
              .where('email',isEqualTo: email)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return new Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    return  new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        //print(document.documentID);

                        return  Padding(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text(
                                                document["company_name"],
                                                style: new TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.5),
                                                maxLines: 1,
                                              ),
                                              new Text(
                                                document["job_type"],
                                                style: new TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.5,
                                                    color: Colors.blue[300]),
                                                maxLines: 1,
                                              ),
                                              new Text(
                                                document["job_location"],
                                                style: new TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.5,
                                                    color: Colors.blue[300]),
                                                maxLines: 1,
                                              ),
                                            ]),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  buildJobDetail(
                                                      job_title:
                                                          document["job_title"],
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
                                                      time: document["time"],
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
                              );
                      }).toList(),
                    );
                }
              },
            ),
            floatingActionButton: Container(
              height: 70.0,
              width: 70.0,
              child: FittedBox(
                child: FloatingActionButton(
                  tooltip: 'Increment',
                  backgroundColor: appBlueColor,
                  child: Icon(
                    Icons.playlist_add,
                    color: appBlackColor,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(B_PostJob_formTag);
                  },
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: appWhiteColor,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login first',
                  style: TextStyle(color: appGreyColor, fontSize: 20),
                ),
              ],
            )));
  }
}
