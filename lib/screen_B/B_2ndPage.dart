import 'package:appnewv1/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/screen_B/B_MainPage.dart';

class B_2ndPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: appBlueColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment:   CrossAxisAlignment.center,

              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1000.0),
                ),
                titletxt(),
                padding1(),
                _btn_1(context),
                padding1(),
                _btn_2(context),
                padding1(),
                _btn_3(context),
                padding1(),
                _page2_Image(context),
              ]),
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget titletxt() {
    return Text("我想刊登...",
        style: TextStyle(
          fontSize: 20.0,
          height: 1.5,
          color: appDeepBlueColor, //You can set your custom height here
        ));
  }

  Widget padding1() {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: appBlueColor,
    );
  }

  Widget _btn_1(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 7.7,
      child: RaisedButton(
        onPressed: () {
          gotopage1_B();
          Navigator.of(context).pushNamed(B_MainPageTag);
        },
        color: Colors.white,
        elevation: 3,
        padding: const EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(
              Icons.card_travel,
              color: appGreenBlueColor,
              size: MediaQuery.of(context).size.width / 12,
            ),
            Text(
              "公司職缺",
              style: TextStyle(color: appGreenBlueColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _btn_2(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 7.7,
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(B_PostMission_formTag);
        },
        color: Colors.white,
        elevation: 3,
        padding: const EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: appGreenBlueColor,
              size: MediaQuery.of(context).size.width / 12,
            ),
            Text(
              "即時任務",
              style: TextStyle(color: appGreenBlueColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _btn_3(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 7.7,
      child: RaisedButton(
        onPressed: () {},
        color: Colors.white,
        elevation: 3,
        padding: const EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(
              Icons.create,
              color: appGreenBlueColor,
              size: MediaQuery.of(context).size.width / 12,
            ),
            Text(
              "我諗唔到",
              style: TextStyle(color: appGreenBlueColor),
            )
          ],
        ),
      ),
    );
  }

  Widget _page2_Image(BuildContext context) {
    return Image.asset(
      'assets/images/icons/pig2.png',
      width: MediaQuery.of(context).size.width / 3,
    );
  }
}
