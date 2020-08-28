import 'dart:math';

import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:appnewv1/services/database.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:appnewv1/screen_C/C_ListJobDetail.dart';

import 'package:database/database.dart' hide Column;
import 'package:database/sql.dart';
import 'package:database_adapter_postgre/database_adapter_postgre.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:carousel_slider/carousel_slider.dart';

//Map joblist = Map<String, dynamic>();
List joblistlist = [];

bool isLoading = false;

int selectedIndex = 0;
int clickindex = 0;

List tabs = ["地區", "時段", "篩選"];
List listname = ["全部打工", "搜尋打工"];

int listname_index = 0;

bool abcd = false;

bool filterlistOn = false;

class C_listJob extends StatefulWidget {
  @override
  createState() {
    return _C_listJobState();
  }
}

class _C_listJobState extends State<C_listJob> {
  String email;

  getemail() async {
    if (userIsLoggedIn == true) {
      await HelperFunctions.getUserEmailSharedPreference().then((value) {
        setState(() {
          email = value.toString();
        });
      });
    }
  }

//  final database = Postgre(
//    host: '10.0.2.2',
//    port: 5432,
//    user: 'postgres',
//    password: 'ocg123',
//    databaseName: 'appdb',
//  ).database();

  Future start() async {
    final database = Postgre(
      host: '10.0.2.2',
      port: 5432,
      user: 'postgres',
      password: 'ocg123',
      databaseName: 'appdb',
    ).database();

    final iterator = await database.sqlClient
        .query(
          'SELECT * FROM jobposts',
        )
        .getIterator();
    for (var row in await iterator.toRows()) {
      isLoading = true;
      setState(() {
        joblistlist.add(row);
      });
    }
    //print(joblistlist[0][0]);
    isLoading = false;
    globalJobList = joblistlist;
    //print(joblistlist.length);
    //print(joblistlist[0]['lat']);
  }

  void initState() {
    //saved.clear();
    joblistlist = [];
    globalJobList = [];
    start();
    getemail();
    getLoggedInState();
    selectedChoices = List();
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
          buttonMinWidth: (MediaQuery.of(context).size.width / 2) - 2,
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
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) => bottomBar1(),
                  );
                }),
/*            Container(
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
            ),*/
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
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) => bottomBar(),
                );
              },
            ),
            Container(
              height: 40,
              child: VerticalDivider(),
              width: 1,
            ),
          ],
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max),
//      ButtonBar(
//          buttonMinWidth: (MediaQuery.of(context).size.width / 3) - 2,
//          buttonPadding: EdgeInsets.all(0),
//          children: [
//            FlatButton.icon(
//                label: Text(
//                  "地區",
//                  style: TextStyle(color: appDeepBlueColor),
//                ),
//                icon: Icon(
//                  Icons.arrow_drop_down,
//                  color: appDeepBlueColor,
//                ),
//                onPressed: () {
//                  _isButton1Disable
//                      ? {_isButton1Disable = false, _overlayEntry1.remove()}
//                      : {
//                          _overlayEntry1 = _createOverlayEntry1(),
//                          _overlay1.insert(_overlayEntry1),
//                          _isButton1Disable = true,
//                        };
//                }),
//            Container(
//              height: 40,
//              child: VerticalDivider(),
//              width: 1,
//            ),
//            FlatButton.icon(
//              label: Text(
//                "時段",
//                style: TextStyle(color: appDeepBlueColor),
//              ),
//              icon: Icon(
//                Icons.arrow_drop_down,
//                color: appDeepBlueColor,
//              ),
//              onPressed: () => {},
//            ),
//            Container(
//              height: 40,
//              child: VerticalDivider(),
//              width: 1,
//            ),
//            FlatButton.icon(
//              label: Text(
//                "篩選",
//                style: TextStyle(color: appDeepBlueColor),
//              ),
//              icon: Icon(
//                Icons.arrow_drop_down,
//                color: appDeepBlueColor,
//              ),
//              onPressed: () => {},
//            ),
//            Container(
//              height: 40,
//              child: VerticalDivider(),
//              width: 1,
//            ),
//          ],
//          alignment: MainAxisAlignment.center,
//          mainAxisSize: MainAxisSize.max),

/*new Image.asset(
        'assets/images/icons/banner.png',
        width: double.infinity,
      ),*/
      CarouselWithIndicatorDemo(),
      Container(
        child: list_Jobpost(),
      )
    ]);
  }

  Future filter(String q) async {
    final database = Postgre(
      host: '10.0.2.2',
      port: 5432,
      user: 'postgres',
      password: 'ocg123',
      databaseName: 'appdb',
    ).database();

    setState(() {
      joblistlist = [];
    });
    final iterator = await database.sqlClient
        .query(
          q,
        )
        .getIterator();
    for (var row in await iterator.toRows()) {
      isLoading = true;
      setState(() {
        joblistlist.add(row);
      });
    }

    isLoading = false;
  }

  String queryfilter1 = "SELECT * FROM jobposts WHERE 1=1";

  Widget bottomBar() {
    return Container(
      height: (MediaQuery.of(context).size.height / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            "Choose Salary Type",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          MultiSelectChip(
            reportList,
            onSelectionChanged: (selectedList) {
              setState(() {
                selectedReportList = selectedList;
              });
            },
          ),
          RaisedButton(
            onPressed: () {
              String queryA = " AND job_salary_type = '時薪'";
              String queryB = " OR job_salary_type = '日薪'";
              String queryC = " OR job_salary_type = '月薪'";
              //String queryfilter1 = queryfilter;

              if (selectedChoices.contains('時薪') &&
                  selectedChoices.contains('日薪') &&
                  selectedChoices.contains('月薪')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');

                queryfilter1 = queryfilter1 + queryA + queryB + queryC;
              }

              if (selectedChoices.contains('時薪') &&
                  selectedChoices.contains('日薪') &&
                  !selectedChoices.contains('月薪')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');

                queryfilter1 = queryfilter1 + queryA + queryB;
              }

              if (selectedChoices.contains('時薪') &&
                  !selectedChoices.contains('日薪') &&
                  selectedChoices.contains('月薪')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');

                queryfilter1 = queryfilter1 + queryA + queryC;
              }

              if (selectedChoices.contains('時薪') &&
                  !selectedChoices.contains('日薪') &&
                  !selectedChoices.contains('月薪')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');

                queryfilter1 = queryfilter1 + queryA;
              }

              if (!selectedChoices.contains('時薪') &&
                  selectedChoices.contains('日薪') &&
                  selectedChoices.contains('月薪')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');

                queryfilter1 =
                    queryfilter1 + " AND job_salary_type = '日薪'" + queryC;
              }

              if (!selectedChoices.contains('時薪') &&
                  selectedChoices.contains('日薪') &&
                  !selectedChoices.contains('月薪')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');

                queryfilter1 = queryfilter1 + " AND job_salary_type = '日薪'";
              }

              if (!selectedChoices.contains('時薪') &&
                  !selectedChoices.contains('日薪') &&
                  selectedChoices.contains('月薪')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');

                queryfilter1 = queryfilter1 + " AND job_salary_type = '月薪'";
              }

              if (!selectedChoices.contains('時薪') &&
                  !selectedChoices.contains('日薪') &&
                  !selectedChoices.contains('月薪')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');

                queryfilter1 = queryfilter1;
                setState(() {
                  listname_index = 0;
                });
              } else {
                setState(() {
                  listname_index = 1;
                });
              }

              if (!selectedChoices.contains('月薪')) {
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '月薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" OR job_salary_type = '月薪'", '');
              }
              if (!selectedChoices.contains('日薪')) {
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '日薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" OR job_salary_type = '日薪'", '');
              }
              if (!selectedChoices.contains('時薪')) {
                queryfilter1 =
                    queryfilter1.replaceAll(" AND job_salary_type = '時薪'", '');
                queryfilter1 =
                    queryfilter1.replaceAll(" OR job_salary_type = '時薪'", '');
                //queryfilter1 = "SELECT * FROM jobposts WHERE 1=1";
              }

              //print(queryfilter1);
              filter(queryfilter1);

              Navigator.pop(context);
            },
            child: Text(
              "Filter",
            ),
          ),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget bottomBar1() {
    return Container(
      height: (MediaQuery.of(context).size.height / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            "choose 打工區域",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          MultiSelectChip(
            reportList1,
            onSelectionChanged: (selectedList1) {
              setState(() {
                selectedReportList = selectedList1;
              });
            },
          ),
          RaisedButton(
            onPressed: () {
              String queryA = " AND area = '新界區'";
              String queryB = " OR area = '九龍區'";
              String queryC = " OR area = '港島區'";
              String queryD = " OR area = '離島區'";

              //String queryfilter1 = queryfilter;
              //0000
              if (selectedChoices.contains('新界區') &&
                  selectedChoices.contains('九龍區') &&
                  selectedChoices.contains('港島區') &&
                  selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + queryA + queryB + queryC + queryD;
              }
//0001
              if (selectedChoices.contains('新界區') &&
                  selectedChoices.contains('九龍區') &&
                  selectedChoices.contains('港島區') &&
                  !selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + queryA + queryB + queryC;
              }
//0010
              if (selectedChoices.contains('新界區') &&
                  selectedChoices.contains('九龍區') &&
                  !selectedChoices.contains('港島區') &&
                  selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + queryA + queryB + queryD;
              }
//0011
              if (selectedChoices.contains('新界區') &&
                  selectedChoices.contains('九龍區') &&
                  !selectedChoices.contains('港島區') &&
                  !selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + queryA + queryB;
              }

              //0100
              if (selectedChoices.contains('新界區') &&
                  !selectedChoices.contains('九龍區') &&
                  selectedChoices.contains('港島區') &&
                  selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + queryA + queryC + queryD;
              }

              //0101
              if (selectedChoices.contains('新界區') &&
                  !selectedChoices.contains('九龍區') &&
                  selectedChoices.contains('港島區') &&
                  !selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + queryA + queryC;
              }
//0110
              if (selectedChoices.contains('新界區') &&
                  !selectedChoices.contains('九龍區') &&
                  !selectedChoices.contains('港島區') &&
                  selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + queryA + queryD;
              }

              //0111
              if (selectedChoices.contains('新界區') &&
                  !selectedChoices.contains('九龍區') &&
                  !selectedChoices.contains('港島區') &&
                  !selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + queryA;
              }

              //1000
              if (!selectedChoices.contains('新界區') &&
                  selectedChoices.contains('九龍區') &&
                  selectedChoices.contains('港島區') &&
                  selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 =
                    queryfilter1 + " AND area = '九龍區'" + queryC + queryD;
              }

              //1001
              if (!selectedChoices.contains('新界區') &&
                  selectedChoices.contains('九龍區') &&
                  selectedChoices.contains('港島區') &&
                  !selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + " AND area = '九龍區'" + queryC;
              }

              //1010
              if (!selectedChoices.contains('新界區') &&
                  selectedChoices.contains('九龍區') &&
                  !selectedChoices.contains('港島區') &&
                  selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + " AND area = '九龍區'" + queryD;
              }

              //1011
              if (!selectedChoices.contains('新界區') &&
                  selectedChoices.contains('九龍區') &&
                  !selectedChoices.contains('港島區') &&
                  !selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + " AND area = '九龍區'";
              }
              //1100
              if (!selectedChoices.contains('新界區') &&
                  !selectedChoices.contains('九龍區') &&
                  selectedChoices.contains('港島區') &&
                  selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + " AND area = '港島區'" + queryD;
              }

              //1101
              if (!selectedChoices.contains('新界區') &&
                  !selectedChoices.contains('九龍區') &&
                  selectedChoices.contains('港島區') &&
                  !selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + " AND area = '港島區'";
              }

              //1110
              if (!selectedChoices.contains('新界區') &&
                  !selectedChoices.contains('九龍區') &&
                  !selectedChoices.contains('港島區') &&
                  selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1 + " AND area = '離島區'";
              }
//1111
              if (!selectedChoices.contains('新界區') &&
                  !selectedChoices.contains('九龍區') &&
                  !selectedChoices.contains('港島區') &&
                  !selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(queryA, '');
                queryfilter1 = queryfilter1.replaceAll(queryB, '');
                queryfilter1 = queryfilter1.replaceAll(queryC, '');
                queryfilter1 = queryfilter1.replaceAll(queryD, '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');

                queryfilter1 = queryfilter1;
                setState(() {
                  listname_index = 0;
                });
              } else {
                setState(() {
                  listname_index = 1;
                });
              }

              if (!selectedChoices.contains('港島區')) {
                queryfilter1 = queryfilter1.replaceAll(" AND area = '港島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" OR area = '港島區'", '');
              }
              if (!selectedChoices.contains('新界區')) {
                queryfilter1 = queryfilter1.replaceAll(" AND area = '新界區'", '');
                queryfilter1 = queryfilter1.replaceAll(" OR area = '新界區'", '');
              }
              if (!selectedChoices.contains('離島區')) {
                queryfilter1 = queryfilter1.replaceAll(" AND area = '離島區'", '');
                queryfilter1 = queryfilter1.replaceAll(" OR area = '離島區'", '');
              }
              if (!selectedChoices.contains('九龍區')) {
                queryfilter1 = queryfilter1.replaceAll(" AND area = '九龍區'", '');
                queryfilter1 = queryfilter1.replaceAll(" OR area = '九龍區'", '');
              }

              //print(queryfilter1);
              filter(queryfilter1);

              Navigator.pop(context);
            },
            child: Text(
              "Filter",
            ),
          ),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }

  divider1() {
    return Divider(
      height: 1.0,
      thickness: 1,
    );
  }
}

List<String> reportList = [
  "時薪",
  "日薪",
  "月薪",
];

List<String> reportList1 = [
  "新界區",
  "九龍區",
  "港島區",
  "離島區",
];

List<String> selectedReportList = List();
List<String> selectedReportList1 = List();

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged; // +added
  MultiSelectChip(this.reportList, {this.onSelectionChanged} // +added
      );
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

List<String> selectedChoices = List();

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(3.0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ChoiceChip(
            selectedColor: applightpinkColor,
            backgroundColor: applightGreyColor,
            label: Container(
                width: (MediaQuery.of(context).size.width / 8),
                height: 30,
                child: Center(
                    child: Text(
                  item,
                  style: TextStyle(
                      fontSize: 15,
                      color: appBlackColor,
                      fontWeight: FontWeight.bold),
                ))),
            selected: selectedChoices.contains(item),
            onSelected: (selected) {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged(selectedChoices);

                //print(selectedReportList); // +added
              });
            },
          ),
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
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

  Widget list_sm() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: Transform.rotate(
        angle: 90 * pi / 180,
        child: Icon(
          Icons.remove,
          color: Colors.lightBlue,
        ),
      ),
      title: Align(
        child: Text(listname[listname_index],
            style: TextStyle(color: appDeepBlueColor, fontSize: 15)),
        alignment: Alignment(-1.3, 0),
      ),
      dense: true,
    );
  }

  Widget list_sm2() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: Transform.rotate(
        angle: 90 * pi / 180,
        child: Icon(
          Icons.remove,
          color: Colors.lightBlue,
        ),
      ),
      title: Align(
        child: Text("熱門打工",
            style: TextStyle(color: appDeepBlueColor, fontSize: 15)),
        alignment: Alignment(-1.3, 0),
      ),
      dense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Expanded(
            child: SingleChildScrollView(
                child: (joblistlist.length < 1)
                    ? Center(
                        child: Column(children: [
                          Image.asset(
                            'assets/images/icons/pignojob.png',
                            width: double.infinity,
                          ),
                          Text(
                            "沒有打工資料",
                            style: TextStyle(
                                color: applightGreyColor, fontSize: 18),
                          )
                        ]),
                      )
                    : Column(
                        children: <Widget>[
                          list_sm2(),
                          divider_1(),
                          Card(
                            child: new Column(
                              children: <Widget>[
                                Container(
                                    height: 100.0,
                                    child: new ListTile(
                                        title: new Text(
                                          joblistlist[0][1],
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
                                                joblistlist[0][0],
                                                style: new TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.5),
                                                maxLines: 1,
                                              ),
                                              new Text(
                                                joblistlist[0][2],
                                                style: new TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.5,
                                                    color: Colors.blue[300]),
                                                maxLines: 1,
                                              ),
                                              new Text(
                                                joblistlist[0][4] +
                                                    " " +
                                                    joblistlist[0][10] +
                                                    "  " +
                                                    joblistlist[0][11],
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
                                                builder: (context) => buildJobDetail(
                                                    job_title: joblistlist[0]
                                                        [1],
                                                    job_salary_type:
                                                        joblistlist[0][4],
                                                    job_salary: joblistlist[0]
                                                        [10],
                                                    job_location: joblistlist[0]
                                                        [5],
                                                    company_name: joblistlist[0]
                                                        [0],
                                                    job_detail: joblistlist[0]
                                                        [3],
                                                    time: joblistlist[0][6],
                                                    lat: double.parse(
                                                        joblistlist[0][8]),
                                                    lng: double.parse(
                                                        joblistlist[0][9]),
                                                    email: joblistlist[0][7],
                                                    username_db: joblistlist[0]
                                                        [13],
                                                    timerange: joblistlist[0]
                                                        [12]),
                                              ));
                                          //setState(() {});
                                        }))
                              ],
                            ),
                          ),
                          list_sm(),
                          divider_1(),
                          Column(
                            children: joblistlist
                                .map(
                                  (element) => Card(
                                    child: new Column(
                                      children: <Widget>[
                                        Container(
                                            height: 100.0,
                                            child: new ListTile(
                                                title: new Text(
                                                  element[1],
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
                                                        element[0],
                                                        style: new TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            height: 1.5),
                                                        maxLines: 1,
                                                      ),
                                                      new Text(
                                                        element[2],
                                                        style: new TextStyle(
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            height: 1.5,
                                                            color: Colors
                                                                .blue[300]),
                                                        maxLines: 1,
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                              child: new Text(
                                                                element[4] +
                                                                    " " +
                                                                    element[10] +
                                                                    "  " +
                                                                    element[11]+"",
                                                                style: new TextStyle(
                                                                    fontSize: 13.0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                    height: 1.5,
                                                                    color: Colors
                                                                        .blue[300]),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text (
                                                                HelperFunctions
                                                                    .TimeBetween(
                                                                  DateTime.now(),
                                                                  DateTime
                                                                      .fromMillisecondsSinceEpoch(
                                                                      element[6]),
                                                                ),
                                                                style: TextStyle(
                                                                    fontSize: 13.0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                    height: 1.5,
                                                                    color:
                                                                    appGreyColor),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                                trailing:
                                                    Column(
                                                        children: <Widget>[
                                                  favbutton(
                                                  index : joblistlist.indexOf(element)),
                                                  Expanded(
                                                      child: Text("new",
                                                          style: TextStyle(
                                                              fontSize: 3))),
                                                ]),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            buildJobDetail(
                                                                job_title:
                                                                    element[1],
                                                                job_salary_type:
                                                                    element[4],
                                                                job_salary:
                                                                    element[10],
                                                                job_location:
                                                                    element[5],
                                                                company_name:
                                                                    element[0],
                                                                job_detail:
                                                                    element[3],
                                                                time:
                                                                    element[6],
                                                                lat: double.parse(
                                                                    element[8]),
                                                                lng: double
                                                                    .parse(
                                                                        element[
                                                                            9]),
                                                                email:
                                                                    element[7],
                                                                username_db:
                                                                    element[13],
                                                                timerange:
                                                                    element[
                                                                        12]),
                                                      ));
                                                  //setState(() {});
                                                }))
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      )));

/*      Card(
        child: new Column(
      children: <Widget>[
        Container(
          height: 100.0,
          child: new ListTile(
            title: new Text(
              "a",
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
                    "a",
                    style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        height: 1.5),
                    maxLines: 1,
                  ),
                  new Text(
                    "a",
                    style: new TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: Colors.blue[300]),
                    maxLines: 1,
                  ),
                  new Text(
                    "a",
                    style: new TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: Colors.blue[300]),
                    maxLines: 1,
                  ),
                ]),
            */
/*trailing: Padding(
                padding: const EdgeInsets.all(0.0),
                child:
                    favbutton(documentID: document.documentID, email: email)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => buildJobDetail(
                      job_title: document["job_title"],
                      job_salary_type: document["job_salary_type"],
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
            },*/ /*
          ),
        )
      ],
    ));*/
  }

  Widget divider_1() {
    return Divider(
      height: 1.0,
      thickness: 1,
    );
  }
}

class favbutton extends StatefulWidget {
//  final String documentID;
//  final String email;
//  favbutton({this.documentID, this.email});

  final int index;
  favbutton({ this.index});
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

              if (saved.isEmpty){
                savedJoblist.clear();
              }
              //savedJoblist = Set<List>();
              //print("not favorit");
//              DatabaseMethods().deleteUserFav(widget.email, widget.documentID);
            }
            if (alreadySaved == false && userIsLoggedIn == true) {
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

List imgList = [
  'assets/images/icons/banner.png',
  'assets/images/icons/work.png',
  'assets/images/icons/pig2.png'
];
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: ClipRRect(
              child: Stack(
            children: <Widget>[
              Image.asset(
                item,
              ),
            ],
          )),
        ))
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
            height: (MediaQuery.of(context).size.height / 8),
            autoPlay: true,
            enlargeCenterPage: false,
            aspectRatio: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.map((url) {
          int index = imgList.indexOf(url);
          return Container(
            width: 7.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
