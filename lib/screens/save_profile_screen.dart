// import 'dart:html';

// import 'dart:html';
import 'dart:convert';
import 'dart:io';
// import 'dart:js';

import 'package:path/path.dart' as path;
import 'package:async/async.dart';
// import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/update_profile_screen.dart';
import 'package:equal_cash/screens/updated_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SaveProfileScreen extends StatefulWidget {
  static const routeName = "save-profile";
  @override
  _SaveProfileScreenState createState() => _SaveProfileScreenState();
}

enum Gender { Male, Female }

class _SaveProfileScreenState extends State<SaveProfileScreen> {
  Gender _gender = Gender.Male;

  final _emailController = TextEditingController();

  File _image;
  final picker = ImagePicker();
  bool _isUploaded = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  bool isAddress = false;
  bool isImage = false;

  Future<void> _uploadImage() async {
    if (_image == null) {
      setState(() {
        isImage = true;
      });
      return;
    }

    setState(() {
      _isUploaded = true;
    });

    SharedPreferences myId = await SharedPreferences.getInstance();
    String myIdee = myId.getString("userId");

    final urlPic =
        "https://peertopeer.staging.cloudware.ng/api/upload_profile_pic.php";
    var stream = new http.ByteStream(
      DelegatingStream.typed(_image.openRead()),
    );
    var length = await _image.length();

    var uri = Uri.parse(urlPic);

    var request = new http.MultipartRequest("POST", uri);

    request.fields["user_id"] = myIdee;

    var multipartFile =
        new http.MultipartFile('file', stream, length, filename: _image.path);

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print("VALUE $value");
    });
  }

  Future<void> _submit() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        isAddress = true;
      });
      return;
    }
    //UPLOADED CHECK
    if (_image == null || !_isUploaded) {
      setState(() {
        isImage = true;
      });
      return;
    }

    String userGender;
    if (_gender == Gender.Male) {
      userGender = "Male";
    } else {
      userGender = "Female";
    }

    print("GENDER $userGender");

    print("FILE $_image");

    String address = _emailController.text;

    Future.delayed(Duration(seconds: 4), () {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Profile updated',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              content: Text(
                "Your profile has being successfully updated",
                style: TextStyle(fontSize: 11),
              ),
            );
          });
    });

    Future.delayed(Duration(seconds: 6), () {
      Navigator.of(context).pushNamed(UpdatedProfileScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Save profile",
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home_rounded),
              onPressed: () =>
                  Navigator.of(context).pushNamed(HomeScreen.routeName),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Edit profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 80,
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                            splashColor: Colors.white,
                            onTap: getImage,
                            child: _image == null
                                ? Icon(
                                    Icons.person,
                                    size: 30,
                                  )
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: isImage
                        ? Text(
                            "Please click here to upload your profile pic",
                            style: TextStyle(color: Colors.red[900]),
                          )
                        : Text(
                            "CLICK HERE TO CHANGE PICTURE",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                  ),

                  InkWell(
                      onTap: _uploadImage,
                      child: Chip(
                        label: Text(
                          'Upload image',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      )),

                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "GENDER",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  //GENDER
                  Container(
                    child: Row(
                      children: [
                        Radio<Gender>(
                          value: Gender.Male,
                          groupValue: _gender,
                          onChanged: (gender) {
                            setState(() {
                              _gender = gender;
                            });
                          },
                        ),
                        Text(
                          "MALE",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Radio<Gender>(
                          value: Gender.Female,
                          groupValue: _gender,
                          onChanged: (gender) {
                            setState(() {
                              _gender = gender;
                            });
                          },
                        ),
                        Text(
                          "FEMALE",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "ADDRESS",
                      style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.house,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: "Enter address here",
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                  ),
                  !isAddress
                      ? SizedBox()
                      : Text(
                          "Please enter your home address",
                          style: TextStyle(color: Colors.red[900]),
                        ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.symmetric(vertical: 13),
                      onPressed: _submit,
                      child: Text(
                        'Save changes',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Container(
                    child: InkWell(
                        onTap: () {},
                        child: Text(
                          "CANCEL",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
