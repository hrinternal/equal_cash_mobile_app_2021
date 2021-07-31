import 'package:equal_cash/pref.dart';
import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/models/api/login.dart';
import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/screens/forgot_password.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //PASSWORD VISIBILITY
  bool isVisible = false;

  //LOADING
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    var mail = _emailController.text;
    var pass = _passwordController.text;
    ApiRepository()
        .login(LoginParam(email: mail, password: pass))
        .then((value) {
      var data = value.data;
      print(data.response!.status);
      if (data.response!.status == 200) {
        goToHomeScreen(data);
      } else {
        Get.snackbar("", data.response!.message!);
      }
    });

    return;
  }

  void goToHomeScreen(Login data) {
    print(data.toJson());
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              "Login successful",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green[900]),
            ),
            content: Text(
              "Welcome back",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        });

    LoginData loginData = data.response!.data!;

    _saveUser(loginData);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) {
        return HomeScreen();
      }),
    );
  }

  _saveUser(LoginData loginData) async {
    Settings.instance.saveUser(loginData);
    print(Settings.instance.userFullName);
  }

  Map<String, dynamic> savedData = {"email": "", "password": ""};

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
              height: deviceHeight * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              onSaved: (email) {
                                savedData["email"] = email;
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
                                  labelStyle: TextStyle(
                                      fontSize: deviceHeight >= 600 ? 18 : 14)),
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
                              controller: _passwordController,
                              onSaved: (password) {
                                savedData["password"] = password;
                              },
                              validator: (password) {
                                //  if(isLength())
                                if (password!.isEmpty) {
                                  return "Please enter your password";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: isVisible,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      fontSize: deviceHeight >= 600 ? 18 : 14),
                                  suffixIcon: IconButton(
                                      icon: Icon(isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      })),
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
                              onPressed: _submit,
                              child: _isLoading
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
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ))
                                      ],
                                    )
                                  : Text(
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
            Container(
              // color: Colors.amber,
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
