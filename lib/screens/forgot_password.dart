import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/models/api/forgot_password.dart';
import 'package:equal_cash/api/repository.dart';

import 'package:equal_cash/screens/auth_confirmation_screen.dart';
import 'package:equal_cash/screens/login_screen.dart';
import 'package:equal_cash/screens/reset_forgot_password.dart';
import 'package:equal_cash/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "forgot-pass";

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Map<String, String> savedData = {"email": ""};

  bool isLoading = false;

//SUBMIT
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    ApiRepository().forgotPassword(_emailController.text).then((value) {
      var data = value.data;
      var response = data.response;
      if (response!.status == 200) {
        showResetSuccess(data);
      } else {
        Get.snackbar("", response.message!);
      }
    });
  }

  void showResetSuccess(ForgotPassword data) {
    Future.delayed(Duration(seconds: 4), () {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
                title: Text(
                  "Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green[900]),
                ),
                content: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'A reset password link has been sent to ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: savedData['email'],
                      style: TextStyle(
                        color: Colors.red[900],
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ));
          });

      Future.delayed(Duration(seconds: 6), () {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      });
    });
  }

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
                  "Forgot Password?",
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
                  "Keep calm, let's fix it together",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Please enter the email address you registered with. You will get a code to reset your password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Email address",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: //EMAIL
                    Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    controller: _emailController,
                    onSaved: (email) {
                      savedData["email"] = email!;
                    },
                    validator: (email) {
                      print(EmailValidator.validate(email!));
                      if (EmailValidator.validate(email)) {
                        return null;
                      } else {
                        return "Please enter a valid email address";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //REGISTRATION
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(vertical: 18),
                  onPressed: _submit,
                  child: Text(
                    'Send Reset Code',
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
