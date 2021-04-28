import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/providers/auth_provider.dart';
import 'package:equal_cash/screens/forgot_password.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
    CircularProgressIndicator();
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(savedData["email"], savedData["password"]);

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

      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) {
            return HomeScreen();
          }),
        );
      });
    } on HttpException catch (error) {
      Alert(
        style: AlertStyle(
          animationDuration: Duration(milliseconds: 500),
          animationType: AnimationType.fromTop,
          titleStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        // desc: error.message,
        title: error.code == 107 ? "Email Verification" : "Incorrect Details",
        context: context,
        content: Text(
          error.message,
          style: TextStyle(
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        type: error.code == 107 ? AlertType.info : AlertType.warning,
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
        _isLoading = false;
      });
      print(error);
      return;
    } catch (error) {
      throw error;
    }

    setState(() {
      _isLoading = false;
    });
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
                                if (password.isEmpty) {
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
