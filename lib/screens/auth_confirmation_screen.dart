import 'package:equal_cash/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthConfirmationScreen extends StatefulWidget {
  static const String routeName = "auth-confirm";
  @override
  _AuthConfirmationScreenState createState() => _AuthConfirmationScreenState();
}

class _AuthConfirmationScreenState extends State<AuthConfirmationScreen> {
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(121, 128, 235, 1)),
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Confirm it's you",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Verify your identity",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "Please enter the code you received in your mail - ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "cloudware@gmail.com",
                        style: TextStyle(
                          color: Color.fromRGBO(80, 20, 235, 1),
                        )),
                  ]))),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  autoFocus: true,
                  enablePinAutofill: true,
                  showCursor: false,
                  appContext: context,
                  length: 6,
                  animationType: AnimationType.scale,
                  onChanged: (_) {},
                  pinTheme: PinTheme(
                    fieldHeight: 50,
                    fieldWidth: 50,
                    borderRadius: BorderRadius.circular(15),
                    shape: PinCodeFieldShape.box,
                    inactiveColor: Colors.black,
                    selectedColor: Colors.red[900],
                    activeColor: Colors.green[900],
                  ),
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  animationDuration: Duration(milliseconds: 500),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Expires in ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "00:52",
                        style:
                            TextStyle(color: Color.fromRGBO(80, 20, 235, 1))),
                  ]))),
              SizedBox(
                height: 30,
              ),
              //REGISTRATION
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding: EdgeInsets.symmetric(vertical: 18),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ResetPasswordScreen.routeName);
                  },
                  child: Text(
                    'Submit',
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
        ),
      ),
    );
  }
}
