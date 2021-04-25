import 'package:equal_cash/screens/save_profile_screen.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const routeName = "update-profile";
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update profile",
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              _HeaderWidget(),
              Form(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "First name",
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Middle name",
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Last name",
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Please enter your ",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black)),
                          TextSpan(
                              text: "full legal name ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "as shown on your valid id",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black)),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Phone number",
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Date of birth",
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.maxFinite,
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.symmetric(vertical: 13),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SaveProfileScreen.routeName);
                        },
                        child: Text(
                          'Update profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

//HEADER WIDGET
class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          subtitle: Text(
            "Update your profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                // color: Colors.black,
                fontSize: 12),
          ),
          trailing: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 2)),
                height: 55,
                width: 55,
                child: Icon(
                  Icons.person,
                  color: Color.fromRGBO(14, 129, 59, 1),
                ),
              )),
        ),
      ],
    );
  }
}
