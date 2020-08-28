import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceUserLoggedInFBKey = "ISLOGGEDINFB";
  static String sharedPreferenceUserLoggedInEmailKey = "ISLOGGEDINEMAIL";
  static String sharedPreferenceUserFBIconKey = "ISFBICON";
  static String sharedPreferenceUserFavKey = "FavKEY";
  //saving data to SharedPreference

  static Future<void> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<void> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  //getting data from SharedPreference

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }

  static Future<void> saveUserLoggedInFB(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(
        sharedPreferenceUserLoggedInFBKey, isUserLoggedIn);
  }

  static Future<bool> getUserLoggedInFB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInFBKey);
  }

  static Future<void> saveUserFBIcon(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserFBIconKey, url);
  }

  static Future<String> getUserFBIcon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserFBIconKey);
  }

  static Future<void> saveUserLoggedInEmail(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(
        sharedPreferenceUserLoggedInEmailKey, isUserLoggedIn);
  }

  static Future<bool> getUserLoggedInEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInEmailKey);
  }

  static String TimeBetween(DateTime a, DateTime b) {
    var difference = a.difference(b);
    var day = difference.inDays;
    var hour = difference.inHours;
    var min = difference.inMinutes;
    var second = difference.inSeconds;

    //print(DateTime.now().millisecondsSinceEpoch);

    if (day == 0 && hour < 0) {
      //print("3");
      String returnmsg = (0 - hour).toString() + " hours ago";
      return returnmsg;
    }
    if (day == 0 && hour > 0) {
      //print("4");
      String returnmsg = (hour).toString() + " hours ago";
      return returnmsg;
    }
    if (day == 0 && hour == 0 && min > 0) {
      //print("5");
      String returnmsg = (min).toString() + " mins ago";
      return returnmsg;
    }

    if (day > 0 && hour == 0 && min > 0) {
      //print("67");
      String returnmsg =
          (day).toString() + " days " + (min).toString() + " mins ago";
      return returnmsg;
    }
    if (day > 0 && hour > 0 && min > 0) {
      int new_hour = hour%24;
      //print("6");
      String returnmsg =
          (day).toString() + " days " + (new_hour).toString() + " hours ago";
      return returnmsg;
    }

    if (day == 0 && hour == 0 && min == 0 && second > 0) {
      //print("7");
      int new_second = second%60;
      String returnmsg = (new_second).toString() + " sec ago";
      return returnmsg;
    }

    else {
      String returnmsg = "...";
      //print("haha");
      return returnmsg;
    }
  }


}
