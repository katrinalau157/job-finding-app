import 'dart:convert';
import 'package:appnewv1/helpers/constants_login.dart';
import 'package:appnewv1/screen_B/B_MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';

import 'package:database/database.dart' hide Column;
import 'package:database/sql.dart';
import 'package:database_adapter_postgre/database_adapter_postgre.dart';

const double TextField_title_fontsize = 15;
const double TextField_hint_fontsize = 14;
double lat;
double lng;
const String kGoogleApiKey = "AIzaSyATL0Ar3NLs5umBrgIpkvYMkzM_E2zW5pI";
GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

TextEditingController company_nameController = TextEditingController();
TextEditingController job_titleController = TextEditingController();
TextEditingController job_typeController = TextEditingController();
TextEditingController job_detailController = TextEditingController();
TextEditingController job_salary_typeController = TextEditingController();
TextEditingController job_salaryController = TextEditingController();
TextEditingController job_locationController = TextEditingController();

List a = ['時薪', '日薪', '月薪'];
List<bool> isSelected = List.generate(3, (_) => false);
String str_salary1;
int selectedindex;
String username_db ="";
clearTextInput() {
  company_nameController.clear();
  job_titleController.clear();
  job_typeController.clear();
  job_detailController.clear();
  job_salary_typeController.clear();
  job_salaryController.clear();
  job_locationController.clear();

  isSelected = List.generate(3, (_) => false);
  str_salary1 = null;
}

class B_PostJob_form extends StatefulWidget {
  B_PostJob_form({Key key}) : super(key: key);

  @override
  _B_PostJob_formState createState() => _B_PostJob_formState();
}

class _B_PostJob_formState extends State<B_PostJob_form> {
  final _formKey = GlobalKey<FormState>();

  void initState() {
    clearTextInput();
    getEmailInState();
    getUserInfo();
  }

  String email;
  getEmailInState() async {
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        email = value;
      });
    });
  }


  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    username_db = Constants.myName;
  }

  Widget textformfield(TextEditingController textcontroller, String hinttxt,
      String validator_str) {
    return TextFormField(
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hinttxt,
        hintStyle: TextStyle(fontSize: TextField_hint_fontsize),
        contentPadding: EdgeInsets.all(6),
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return validator_str;
        }
        return null;
      },
    );
  }

  ///hererererererererre
  Widget textformfield_place(TextEditingController textcontroller,
      String hinttxt, String validator_str) {
    return TextFormField(
      onTap: () async {
        buttonPressed(context, true);
      },
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hinttxt,
        hintStyle: TextStyle(fontSize: TextField_hint_fontsize),
        contentPadding: EdgeInsets.all(6),
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return validator_str;
        }
        return null;
      },
    );
  }

  Widget textformfield_multi(TextEditingController textcontroller,
      String hinttxt, String validator_str) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hinttxt,
        hintStyle: TextStyle(fontSize: TextField_hint_fontsize),
        contentPadding: EdgeInsets.all(6),
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return validator_str;
        }
        return null;
      },
    );
  }

  Widget txtfieldtitle(String titlename) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: Text(titlename,
            style: TextStyle(
              color: appDeepBlueColor,
              fontSize:
                  TextField_title_fontsize, //You can set your custom height here
            )),
      ),
    );
  }

  Widget textformfield2(TextEditingController textcontroller, String hinttxt,
      String validator_str) {
    return TextFormField(
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hinttxt,
        hintStyle: TextStyle(fontSize: TextField_hint_fontsize),
        contentPadding: EdgeInsets.all(6),
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
      ),
      validator: (value) {
        if (value.isEmpty || str_salary1 == null || str_salary1 == "") {
          return validator_str;
        } else {
          return RegExp(r"^\d+(k?K?)(.?-?\d+)*(k?K?)$").hasMatch(value)
              ? null
              : "Please Enter Only digital, . , - ,k";
        }
      },
    );
  }

  Widget _space() {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
    );
  }

  String dropdownValue = '人力';

  Widget dropdown() {
    return DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        hint: Text("選擇打工類型"),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            print(dropdownValue);
          });
        },
        items: <String>['人力', '餐飲', '門市', '辦工', '銷售', '補教', '活動','市調','其他']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
  String dropdownValue_location = '新界區';
  Widget dropdown_location() {
    return DropdownButton<String>(
        value: dropdownValue_location,
        isExpanded: true,
        hint: Text("選擇打工類型"),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue_location = newValue;
            print(dropdownValue_location);
          });
        },
        items: <String>['新界區', '九龍區', '港島區', '離島區']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,

            child: Text(value),
          );
        }).toList());
  }


  String dropdownValue_time = '朝早-夜晚 ( 06:00 - 18:00 )';
  Widget dropdown_time() {
    return DropdownButton<String>(
        value: dropdownValue_time,
        isExpanded: true,
        hint: Text("選擇打工類型"),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue_time = newValue;
            print(dropdownValue_time);
          });
        },
        items: <String>['朝早-夜晚 ( 06:00 - 18:00 )', '晏晝-凌晨 ( 12:00 - 00:00 )','凌晨 ( 00:00 - 06:00 )']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: appBlueColor,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                gotopage1_B();
                Navigator.pushReplacementNamed(context, B_MainPageTag);
              },
            ),
            title: Text(
              "刊登職缺",
              style: TextStyle(fontSize: 20.0, color: appDeepBlueColor),
            )),

        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //1
                    txtfieldtitle("公司資料"),
                    textformfield(company_nameController, "前往建立公司資料",
                        'Please enter some text'),
                    _space(),
                    _space(),

                    //2
                    txtfieldtitle("標題"),
                    textformfield(job_titleController, "例 : 知名餐廳誠徵晚班工讀生",
                        'Please enter some text'),
                    _space(),
                    _space(),
                    //3
                    txtfieldtitle("打工類型"),
                    dropdown(),
                    _space(),
                    _space(),

                    txtfieldtitle("打工區域"),
                    dropdown_location(),
                    _space(),
                    _space(),

                    txtfieldtitle("打工時間"),
                    dropdown_time(),
                    _space(),
                    _space(),

//                    textformfield(
//                        job_typeController, "選擇打工類型", 'Please enter some text'),

                    //4
                    txtfieldtitle("打工內容"),
                    textformfield_multi(
                        job_detailController, "門市收銀", 'Please enter some text'),
                    _space(),
                    _space(),

                    //5
                    txtfieldtitle("打工待遇"),
                    Center(
                      child: ToggleButtons(
                        children: <Widget>[
                          Text("        時薪        "),
                          Text("        日薪        "),
                          Text("        月薪        "),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < isSelected.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected[buttonIndex] = true;
                                str_salary1 = a[buttonIndex];
                                selectedindex = buttonIndex;
                              } else {
                                isSelected[buttonIndex] = false;
                              }
                            }
                          });
                        },
                        isSelected: isSelected,
                      ),
                    ),
                    textformfield2(job_salaryController, "請輸入金額",
                        'Please enter some text'),
                    _space(),
                    _space(),

                    txtfieldtitle("打工地點"),

                    textformfield_place(job_locationController, "地域地區",
                        'Please enter some text'),

                    _space(),
                    _space(),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            //_formKey.currentState.save();

                            print(job_locationController.text.trim());
                            print(job_titleController.text.trim());
                            print(job_typeController.text.trim());
                            String s = job_detailController.text.toString();

                            print(s);
                            print(str_salary1);
                            print(job_salaryController.text.trim());
                            print(job_locationController.text.trim());
                            print(DateTime.now().millisecondsSinceEpoch);
/*                            if (dropdownValue_location=='新界區'){
                              dropdownValue_location="新界區";
                            }
                            if (dropdownValue_location=='九龍區'){
                              dropdownValue_location="九龍區";
                            }
                            if (dropdownValue_location=='港島區'){
                              dropdownValue_location="港島區";
                            }
                            if (dropdownValue_location=='離島區'){
                              dropdownValue_location="離島區";
                            }*/
/*                            Firestore.instance
                                .collection('JobPost')
                                .document()
                                .setData({
                              'company_name':
                              company_nameController.text.trim(),
                              'job_title': job_titleController.text.trim(),
                              'job_type': job_typeController.text.trim(),
                              'job_detail': job_detailController.text,
                              'job_salary_type': str_salary1,
                              'job_salary': job_salaryController.text.trim(),
                              'job_location':
                              job_locationController.text.trim(),
                              'time': DateTime.now().millisecondsSinceEpoch,
                              'lat': lat,
                              'lng': lng,
                              'email': email
                            });*/

                            String company_name =
                                company_nameController.text.trim();
                            String job_title = job_titleController.text.trim();
                            String job_type = job_typeController.text.trim();
                            String job_detail = job_detailController.text;
                            String job_salary_type = str_salary1;
                            String job_salary =
                                job_salaryController.text.trim();
                            String job_location =
                                job_locationController.text.trim();
                            int time = DateTime.now().millisecondsSinceEpoch;

                            print(username_db);
                            final config = Postgre(
                              host: 'localhost',
                              port: 5432,
                              user: 'your username',
                              password: 'your password',
                              databaseName: 'example',
                            );

                            final sqlClient = config.database().sqlClient;

                            String sqlquery =
                                "INSERT INTO jobposts(company_name, job_title, job_type, job_detail, job_salary_type, job_salary, job_location, time, email, lat, lng, area, timerange,username)VALUES('$company_name','$job_title','$dropdownValue','$job_detail','$job_salary_type','$job_salary','$job_location',$time,'$email','$lat','$lng','$dropdownValue_location','$dropdownValue_time','$username_db')";
                            start(sqlquery);
                            _formKey.currentState.reset();
                            clearTextInput();
                            //Navigator.pop(context);
                            gotopage1_B();
                            Navigator.pushReplacementNamed(
                                context, B_MainPageTag);
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          _formKey.currentState.reset();
                          clearTextInput();
                          //print(username_db);
                          /* Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>  trytry_map(title:"haha")));*/
                        },
                        child: Text('reset'),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  Future start(String a) async {
    String sqlquery = a;
    final database = Postgre(
      host: '10.0.2.2',
      port: 5432,
      user: 'postgres',
      password: 'ocg123',
      databaseName: 'appdb',
    ).database();

    await database.sqlClient.query(sqlquery).getIterator();
  }

  void buttonPressed(BuildContext context, bool isPick) async {
    Prediction p =
        await PlacesAutocomplete.show(context: context, apiKey: kGoogleApiKey);
    Future<PlacesDetailsResponse> placesDetailsResponse =
        getPredictedLatLng(p, isPick);
    placesDetailsResponse.then((detail) {
      var placeId = p.placeId;
      lat = detail.result.geometry.location.lat;
      lng = detail.result.geometry.location.lng;

      //print(p.description);
      job_locationController.text = p.description;
      //Position position = Position(latitude: lat, longitude: lng);
      //updateMap(position, isPick);
    }).catchError((error) {
      //default position
      //Position position = Position(latitude: 10, longitude: 10);
      //updateMap(position, isPick);

      print(error);
    }).whenComplete(() {});
  }

  Future<PlacesDetailsResponse> getPredictedLatLng(
      Prediction p, bool isPickUp) async {
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId);
    return detail;
  }
}
