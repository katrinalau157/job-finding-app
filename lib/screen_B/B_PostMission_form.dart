import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const double TextField_title_fontsize = 15;
const double TextField_hint_fontsize = 14;

TextEditingController _cnameController = TextEditingController();
TextEditingController _jobtitleController = TextEditingController();
TextEditingController _jobtypeController = TextEditingController();

TextEditingController _job_dtlController = TextEditingController();
TextEditingController _job_salary1Controller = TextEditingController();
TextEditingController _job_locateController = TextEditingController();

List a = ['時薪', '日薪', '月薪'];
List<bool> isSelected = List.generate(3, (_) => false);
String str_salary1;
int selectedindex;

clearTextInput(){
  _cnameController.clear();
  _jobtitleController.clear();
  _jobtypeController.clear();
  _job_dtlController.clear();
  _job_salary1Controller.clear();
  isSelected = List.generate(3, (_) => false);
  str_salary1 = null;
}
class B_PostMission_form extends StatefulWidget {
  B_PostMission_form({Key key}) : super(key: key);

  @override
  _B_PostMission_formState createState() => _B_PostMission_formState();
}

class _B_PostMission_formState extends State<B_PostMission_form> {
  final _formKey = GlobalKey<FormState>();

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
        if (value.isEmpty ||str_salary1 == null || str_salary1 =="") {
          return validator_str;
        }
        return null;
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
              "刊登任務",
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
                    txtfieldtitle("個人資料"),
                    textformfield(
                        _cnameController, "陳小豬", 'Please enter some text'),
                    _space(),
                    _space(),
                    //2
                    txtfieldtitle("標題"),
                    textformfield(_jobtitleController, "例 : 10/7 餵小豬飼料",
                        'Please enter some text'),
                    _space(),
                    _space(),
                    //3
                    txtfieldtitle("任務類型"),
                    textformfield(
                        _jobtypeController, "選擇任務類型", 'Please enter some text'),
                    _space(),
                    _space(),
                    //4
                    txtfieldtitle("任務內容"),
                    textformfield(
                        _job_dtlController, "10/7 早晨5點到小豬舍餵食，不同自備飼料", 'Please enter some text'),
                    _space(),
                    _space(),
                    //5
                    txtfieldtitle("單次任務待遇"),
                    textformfield2(
                        _job_salary1Controller, "請輸入金額", 'Please enter some text'),
                    _space(),
                    _space(),

                    txtfieldtitle("打工地點"),
                    textformfield(
                        _job_locateController, "地域地區", 'Please enter some text'),
                    _space(),
                    _space(),
                    txtfieldtitle("支薪日"),
                    textformfield(
                        _job_locateController, "例：當日現領、每月五號", 'Please enter some text'),
                    _space(),
                    _space(),

                    txtfieldtitle("支薪日"),
                    textformfield(
                        _job_locateController, "例：當日現領、每月五號", 'Please enter some text'),
                    _space(),
                    _space(),

                    txtfieldtitle("支薪日"),
                    textformfield(
                        _job_locateController, "例：當日現領、每月五號", 'Please enter some text'),
                    _space(),
                    _space(),

                    txtfieldtitle("支薪日"),
                    textformfield(
                        _job_locateController, "例：當日現領、每月五號", 'Please enter some text'),
                    _space(),
                    _space(),


                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            print("yeah");
                            //_formKey.currentState.save();
                            print(_cnameController.text);
                            print(str_salary1);
                            _formKey.currentState.reset();
                            /*              Firestore.instance
                                .collection('JobPost')
                                .document()
                                .setData({
                              'company_name': _cnameController.text,
                              'job_title': 'volcano'
                            });*/
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
                          _formKey.currentState.reset();
                          clearTextInput();
                        },
                        child: Text('reset'),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
