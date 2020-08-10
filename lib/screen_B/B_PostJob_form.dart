import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';

const double TextField_title_fontsize = 15;
const double TextField_hint_fontsize = 14;
double lat;
double lng;
const String kGoogleApiKey = "AIzaSyATL0Ar3NLs5umBrgIpkvYMkzM_E2zW5pI";
GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

/*
TextEditingController _cnameController = TextEditingController();
TextEditingController _jobtitleController = TextEditingController();
TextEditingController _jobtypeController = TextEditingController();

TextEditingController _job_dtlController = TextEditingController();
TextEditingController _job_salary1Controller = TextEditingController();
TextEditingController _job_locateController = TextEditingController();
*/

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
  }
  String email;
  getEmailInState() async {
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        email = value;
      });
    });
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
/*
      onTap: () async {
        // should show search screen here
        showSearch(
          context: context,
          // we haven't created AddressSearch class
          // this should be extending SearchDelegate
          delegate: AddressSearch(),
        );
      },
*/
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.1,
            backgroundColor: appBlueColor,
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
                    textformfield(
                        job_typeController, "選擇打工類型", 'Please enter some text'),
                    _space(),
                    _space(),
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

                            Firestore.instance
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
                            });

                            _formKey.currentState.reset();
                            clearTextInput();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // _formKey.currentState.reset();
                          // clearTextInput();
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
