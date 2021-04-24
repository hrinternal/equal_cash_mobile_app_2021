import 'package:flutter/material.dart';

class SaveProfileScreen extends StatefulWidget {
  static const routeName = "save-profile";
  @override
  _SaveProfileScreenState createState() => _SaveProfileScreenState();
}

enum Gender { Male, Female }

class _SaveProfileScreenState extends State<SaveProfileScreen> {
  Gender _gender = Gender.Male;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Edit profile",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        child: Image.asset(
                          "assets/images/person.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "CLICK HERE TO CHANGE PICTURE",
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ),
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
                    autofocus: true,
                    // controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter address here",
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
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
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushNamed(SaveProfileScreen.routeName);
                    },
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
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
