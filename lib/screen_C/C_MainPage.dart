import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:appnewv1/screen_C/C_ListJob.dart';
import 'package:appnewv1/screen_C/C_FavJob.dart';
import 'package:appnewv1/screen_C/C_appsetting.dart';
import 'package:appnewv1/screen_C/C_ChatRoom.dart';

Set<int> saved_job = new Set<int>();

int _selectedIndex = 0;

final _pagename = ["打工列表", "收藏打工", "聯絡紀錄", "功能設定"];

final pageOptions = [
  C_listJob(),
  W_Body_favJob_C(),
  ChatRoom_try(),
  //W_Body_C_Chat(),
  C_appSetting()
];

class C_MainPage extends StatefulWidget {
  @override
  C_MainPageState createState() {
    return C_MainPageState();
  }
}

class C_MainPageState extends State<C_MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(_selectedIndex),
      backgroundColor: appWhiteColor,
      body: pageOptions[_selectedIndex],
      bottomNavigationBar: bottomBar(context),
      resizeToAvoidBottomPadding: false,
    );
  }

//app bar
  Widget makeAppBar(int context) {
    return new AppBar(
        elevation: 0.1,
        backgroundColor: appBlueColor,
        title: Text(
          _pagename[context],
          style: TextStyle(
            fontSize: 20.0,
          ),
        ));
  }

//bottom bar set state
  void _onItemTapped(int index) {
    if (index == 1) {}
    setState(() {
      _selectedIndex = index;
    });
  }

//bottom bar
  Widget bottomBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('打工列表'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('收藏打工'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title: Text('聯絡記錄'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('功能設定'),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: appDeepBlueColor,
      onTap: _onItemTapped,
    );
  }
}

//for home page button1
set_selectedindex0_C() {
  _selectedIndex = 0;
}

//for boss page to candidate page
set_selectedindex3_C() {
  _selectedIndex = 3;
}
