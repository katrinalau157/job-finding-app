import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'helpers/Constants.dart';
import 'HomePage.dart';
//C
import 'package:appnewv1/screen_C/C_MainPage.dart';
import 'package:appnewv1/screen_C/C_ListJob.dart';
import 'package:appnewv1/screen_C/C_ListJobDetail.dart';
import 'package:appnewv1/screen_C/C_FavJob.dart';
import 'package:appnewv1/screen_C/C_ChatRoom.dart';
import 'package:appnewv1/screen_C/C_UserSearch.dart';
import 'package:appnewv1/screen_C/C_Conversation.dart';
import 'package:appnewv1/screen_C/C_appsetting.dart';
import 'package:appnewv1/screen_C/C_Login.dart';
import 'package:appnewv1/screen_C/C_profile.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';

//signin/signup
import 'email_signin.dart';
import 'email_signup.dart';

//B
import 'package:appnewv1/screen_B/B_2ndPage.dart';
import 'package:appnewv1/screen_B/B_MainPage.dart';
import 'package:appnewv1/screen_B/B_PostJob_form.dart';
import 'package:appnewv1/screen_B/B_PostMission_form.dart';
import 'package:appnewv1/screen_B/B_appSetting.dart';
import 'package:appnewv1/screen_B/B_justforfun.dart';

//per
import 'helpers/authenticate.dart';
import 'package:appnewv1/problem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
  void initState() {
    // TODO: implement initState
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((val){
      setState(() {
        userIsLoggedIn = val;
      });
    });
  }

  @override
  final routes = <String, WidgetBuilder>{
    //loginPageTag: (context) => LoginPage(),
    HomePageTag: (context) => HomePage(),
    B_2ndPageTag: (context) => B_2ndPage(),
    JustForFunTag: (context) => Justforfun(),
    C_MainPageTag: (context) => C_MainPage(),
    B_MainPageTag: (context) => B_MainPage(),
    B_PostMission_formTag: (context) => B_PostMission_form(),
    B_PostJob_formTag: (context) => B_PostJob_form(),
    B_appSettingTag: (context) => B_appSetting(),
    C_appSettingTag: (context) => C_appSetting(),
    //B_MainPageTag: (context) => B_MainPage(),
    C_loginTag: (context) => C_login(),
    C_profileTag: (context) => C_profile(),
    C_emailSigninTag: (context) => Authenticate(),
    C_emailSignupTag: (context) => Authenticate(),
    ChatRoom_tryTag: (context) => ChatRoom_try(),
    problem_pageTag: (context) => problem_page(),
    //ConversationScreenTag: (context) => ConversationScreen(),
  };

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(), //LoginPage(), // just added
        routes: routes);
  }
}
