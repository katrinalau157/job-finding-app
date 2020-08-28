import 'package:appnewv1/helpers/Constants.dart';
import 'package:database_adapter_postgre/database_adapter_postgre.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:appnewv1/screen_C/C_ListJobDetail.dart';
import 'package:appnewv1/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appnewv1/screen_B/B_PostJob_form.dart';
class W_Body_listJob_B extends StatefulWidget {
  @override
  _W_Body_listJob_BState createState() {
    return _W_Body_listJob_BState();
  }
}

List B_joblistlist = [];
bool isLoading = false;
bool userIsLoggedIn1;
class _W_Body_listJob_BState extends State<W_Body_listJob_B> {
  String _email;

  String q;
  String qemail;
  @override
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn1 = value;
      });
    });
  }

  getemail() async {
      await HelperFunctions.getUserEmailSharedPreference().then((value) {
        setState(() {
          _email = value.toString();
          qemail = "SELECT * FROM jobposts WHERE email='$_email'".trim();
          emailJob(qemail);
        });
      });
  }

  @override
  void initState() {
    //saved.clear();
    B_joblistlist = [];
    getemail();
    getLoggedInState();
    //start();
    //print(email);
  }

/*  getUserInfo(String email) async {
    return Firestore.instance
        .collection("JobPost")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }*/

/*  @override
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
  }*/
  @override
/*  Widget build(BuildContext context) {
    return (userIsLoggedIn != null && userIsLoggedIn == true)
        ? Scaffold(
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
    ) : Scaffold(
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
  }*/

  Future emailJob(String q) async {
    final database = Postgre(
      host: '10.0.2.2',
      port: 5432,
      user: 'postgres',
      password: 'ocg123',
      databaseName: 'appdb',
    ).database();

    final iterator = await database.sqlClient
        .query(q,).getIterator();
    for (var row in await iterator.toRows()) {
      isLoading = true;
      setState(() {
        B_joblistlist.add(row);
      });
    }

    isLoading = false;
  }

  Widget build(BuildContext context) {
    return getjoblist();
  }

}

class getjoblist extends StatefulWidget {
  @override
  _getjoblistState createState() => _getjoblistState();
}

class _getjoblistState extends State<getjoblist> {
  refresh() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return (userIsLoggedIn1 != null && userIsLoggedIn1 == true)
        ?  Scaffold(
          body: SingleChildScrollView(
      child: (B_joblistlist.length < 1)
            ?  Center(
        child: Column(children: [
          Image.asset(
            'assets/images/icons/pignojob.png',
            width: double.infinity,
          ),
          Text("沒有打工資料", style: TextStyle(color: applightGreyColor,fontSize: 18),)
        ]),
      )
            : Column(
          children: B_joblistlist
              .map(
                (element) =>
                Card(
                  child: new Column(
                    children: <Widget>[
                      Container(
                          height: 100.0,
                          child: new ListTile(
                              title: new Text(
                                element[1],
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
                                      element[0],
                                      style: new TextStyle(
                                          fontSize: 15.0,
                                          fontWeight:
                                          FontWeight.normal,
                                          height: 1.5),
                                      maxLines: 1,
                                    ),
                                    new Text(
                                      element[2],
                                      style: new TextStyle(
                                          fontSize: 13.0,
                                          fontWeight:
                                          FontWeight.normal,
                                          height: 1.5,
                                          color: Colors.blue[300]),
                                      maxLines: 1,
                                    ),
                                    new Text(
                                      element[4] + " " + element[10],
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
                                            job_title: element[1],
                                            job_salary_type: element[4],
                                            job_salary: element[10],
                                            job_location: element[5],
                                            company_name: element[0],
                                            job_detail: element[3],
                                            time: element[6],
                                            lat: double.parse(element[8]),
                                            lng: double.parse(element[9]),
                                              email: element[7],
                                              username_db: element[13],
                                              timerange: element[12]
                                          ),
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
             // Navigator.of(context).pushNamed(B_PostJob_formTag);
              Navigator.pushReplacementNamed(context, B_PostJob_formTag);
            },
          ),
        ),
      ),):Scaffold(
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
        ),);
  }
}
