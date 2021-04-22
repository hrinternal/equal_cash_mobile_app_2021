import 'package:equal_cash/screens/forgot_password.dart';
import 'package:equal_cash/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(121, 128, 235, 1)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height:
                  deviceHeight < 600 ? deviceHeight * 0.65 : deviceHeight * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Welcome!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Login to continue using equal cash",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //EMAIL
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          //PASSWORD
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.black),
                                  suffixIcon: IconButton(
                                      color: Colors.black,
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {})),
                            ),
                          ),
                          //FORGOT PASSWORD
                          Container(
                            margin: EdgeInsets.only(top: 20, right: 20),
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ForgotPasswordScreen.routeName);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(88, 20, 235, 1)),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(vertical: 18),
                              onPressed: () {
                                // Navigator.of(context).pushNamed(RegistrationScreen.routeName);
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            //ACCOUNT OPTION
            //ACCOUNT TRANSITION
            SizedBox(
              height: deviceHeight < 600
                  ? deviceHeight * 0.05
                  : deviceHeight * 0.25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        "Not yet a member?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: deviceHeight < 600 ? 12 : 14),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegistrationScreen.routeName);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
