import 'package:appnewv1/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/screen_B/B_Chat.dart';
import 'package:appnewv1/screen_C/C_ListJob.dart';
import 'package:appnewv1/screen_B/B_appSetting.dart';
import 'package:appnewv1/screen_B/B_ListJob.dart';

Set<int> saved_job = new Set<int>();

/*final List<jobads_list> _allJobs = jobads_list.allJobs();
final Set<int> saved = new Set<int>();
int _selectedIndex = 0;*/

int _selectedIndex = 0;
final _pagename = ["職缺管理","聯絡紀錄","功能設定"];

final pageOptions = [W_Body_listJob_B(),B_Chat(),B_appSetting()];

class B_MainPage extends StatefulWidget {

  @override
  B_MainPageState createState() {
    return B_MainPageState();
  }
}

class B_MainPageState extends State<B_MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(_selectedIndex),
      backgroundColor: appWhiteColor,
      body: pageOptions[_selectedIndex],//getJobListBody(context),
      //new jobList(),_
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
          ),)
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget bottomBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('職缺管理'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title: Text('聯絡紀錄'),
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

gotopage1_B(){
  _selectedIndex = 0;
}


gotopage3_B(){
  _selectedIndex = 2;
}