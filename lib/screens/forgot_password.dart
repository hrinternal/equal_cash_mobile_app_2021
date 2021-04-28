import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/providers/auth_provider.dart';
import 'package:equal_cash/screens/auth_confirmation_screen.dart';
import 'package:equal_cash/screens/login_screen.dart';
import 'package:equal_cash/screens/reset_forgot_password.dart';
import 'package:equal_cash/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
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
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .resetPassword(savedData["email"]);

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
                )

                // Text(
                //   "A reset password link has been sent to ${savedData['email']}",
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                );
          });

      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      });
    } on HttpException catch (error) {
      Alert(
        style: AlertStyle(
          animationDuration: Duration(milliseconds: 500),
          animationType: AnimationType.fromTop,
          titleStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        // desc: error.message,
        title: "User not found",
        context: context,
        content: Text(
          error.message,
          style: TextStyle(
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        type: AlertType.info,
        buttons: [
          DialogButton(
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ],
        image: Icon(
          Icons.info,
          color: Colors.red[900],
        ),
      ).show();
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      throw error;
    }
    setState(() {
      isLoading = false;
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
                      savedData["email"] = email;
                    },
                    validator: (email) {
                      print(EmailValidator.validate(email));
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
                  child: isLoading
                      ? Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  "Please wait!!!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ))
                          ],
                        )
                      : Text(
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
