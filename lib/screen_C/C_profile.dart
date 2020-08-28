import 'dart:io';
import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:image_picker/image_picker.dart';

const double TextField_title_fontsize = 15;
const double TextField_hint_fontsize = 14;

TextEditingController _c_nameController = TextEditingController();
TextEditingController _c_birthController = TextEditingController();
TextEditingController _c_residenceController = TextEditingController();

TextEditingController _c_emailController = TextEditingController();
TextEditingController _c_phoneNoController = TextEditingController();
TextEditingController _c_schoolNameController = TextEditingController();
TextEditingController _c_MajorController = TextEditingController();

int selectedindex;
PickedFile imageFile;
final ImagePicker _picker = ImagePicker();

clearTextInput() {
  _c_nameController.clear();
  _c_birthController.clear();
  _c_residenceController.clear();
  _c_emailController.clear();
  _c_phoneNoController.clear();
  _c_schoolNameController.clear();
  _c_MajorController.clear();
}



class C_profile extends StatefulWidget {
  C_profile({Key key}) : super(key: key);
  @override
  _C_profileState createState() => _C_profileState();
}

class _C_profileState extends State<C_profile> {
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
              color: appGreenBlueColor,
              fontSize:
              TextField_title_fontsize, //You can set your custom height here
            )),
      ),
    );
  }

  Widget _space() {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
//        AppBar(
//            elevation: 0.1,
//            backgroundColor: appBlueColor,
//            title: Text(
//              "Profile",
//              style: TextStyle(fontSize: 20.0, color: appDeepBlueColor),
//            )),

        AppBar(
          backgroundColor: appBlueColor,
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop()),title: Text(
          "Profile",
          style: TextStyle(fontSize: 20.0, color: appDeepBlueColor),
        ),),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    imageProfile(),
                    //1
                    txtfieldtitle("姓名"),
                    textformfield(_c_nameController, "陳小豬",
                        'Please enter some text'),
                    _space(),
                    //2
                    txtfieldtitle("生日"),
                    textformfield(_c_birthController, "請選擇生日",
                        'Please enter some text'),
                    _space(),
                    //3
                    txtfieldtitle("居住地"),
                    textformfield(_c_residenceController, "請選擇地區",
                        'Please enter some text'),
                    _space(),
                    //4
                    txtfieldtitle("E-mail"),
                    textformfield(
                        _c_emailController, "alldayworkworkpig@earnmoney.com", 'Please enter some text'),
                    _space(),

                    //5
                    txtfieldtitle("手機"),
                    textformfield(
                        _c_phoneNoController, "21800000", 'Please enter some text'),
                    _space(),

                    //6
                    txtfieldtitle("學校名稱"),
                    textformfield(_c_schoolNameController, "輸入學校關鍵字找找看",
                        'Please enter some text'),
                    _space(),

                    //7
                    txtfieldtitle("科系名稱"),
                    textformfield(
                        _c_MajorController, "輸入科系關鍵字找找看", 'Please enter some text'),
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
                            print(_c_nameController.text);
                            print(_c_birthController.text);
                            print(_c_residenceController.text);
                            print(_c_emailController.text);
                            print(_c_phoneNoController.text);
                            print(_c_schoolNameController.text);
                            print(_c_MajorController.text);
                            //_formKey.currentState.reset();
                            //clearTextInput();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Save'),
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

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: MediaQuery.of(context).size.width / 4,
          backgroundImage: imageFile == null
              ? AssetImage("assets/images/icons/profile_icon.png")
              : FileImage(File(imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.width/2,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.add_photo_alternate),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ]),
          FlatButton.icon(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                imageFile = null;
              });
            },
            label: Text("Remove Icon Image"),
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      imageFile = pickedFile;
    });
  }
}
