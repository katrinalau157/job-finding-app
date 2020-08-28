import 'package:appnewv1/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/screen_C/C_MainPage.dart';
import 'package:appnewv1/helpers/loading.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(),
      backgroundColor: appBlueColor,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1000.0),
              ),
              Text("哈佬，\n今日有無心情返工？",
                  style: TextStyle(
                    fontSize: 20.0,
                    height: 1.5,
                    color:
                    appDeepBlueColor, //You can set your custom height here
                  )),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
              _home_btn_1(context),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
              _home_btn_2(context),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
              _home_Image(context),
            ]),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar() {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: appBlueColor,
    );
  }

  Widget _home_btn_1(BuildContext context) {
    return new ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 2.2,
        height: MediaQuery.of(context).size.height / 16.5,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: RaisedButton(
          onPressed: () {
            set_selectedindex0_C();
            Navigator.of(context).pushNamed(C_MainPageTag);
            //haha();
          },
          child: Text('我要返工',
              style: TextStyle(fontSize: 18.0, color: appDeepBlueColor)),
          color: appBlueColor,
        ));
  }

  Widget _home_btn_2(BuildContext context) {
    return new ButtonTheme(
      //minWidth: 170.0,
        minWidth: MediaQuery.of(context).size.width / 2.2,
        height: MediaQuery.of(context).size.height / 16.5,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(B_2ndPageTag);
          },
          child: Text('我是老細',
              style: TextStyle(fontSize: 18.0, color: appDeepBlueColor)),
          color: appBlueColor,
        ));
  }

  Widget _home_Image(BuildContext context) {
    return Image.asset(
      'assets/images/icons/firstPage_pig1.PNG',
      width: MediaQuery.of(context).size.width / 2,
    );
  }
}
