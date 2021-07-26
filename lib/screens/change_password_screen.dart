import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:string_validator/string_validator.dart' as validator;

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = "change-password";
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map passwords = {"oldPassword": "", "newPassword": "", "confirmPassword": ""};
  bool _isLoading = false;

  bool _isEight;
  bool _isUpperCase;
  bool _isSpecialChar;
  bool _isNumber;

  @override
  void initState() {
    super.initState();
    _isEight = false;
    _isUpperCase = false;
    _isSpecialChar = false;
    _isNumber = false;
  }

  Future _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    SharedPreferences getUserId = await SharedPreferences.getInstance();
    print("GET ID ${getUserId.getString('userId')}");

    Future.delayed(
        Duration(
          seconds: 4,
        ), () {
      Alert(
        style: AlertStyle(
          animationDuration: Duration(milliseconds: 500),
          animationType: AnimationType.fromTop,
          titleStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        // desc: error.message,
        title: "Password changed",
        context: context,
        content: Text(
          "Your password has being changed successfully",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        type: AlertType.success,
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
          Icons.check_circle_outline,
          color: Colors.green[900],
        ),
      ).show();
    });

    Future.delayed(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomeScreen();
      }));
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change password",
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
                  alignment: Alignment.centerLeft,
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Choose a password that meets the criteria listed below",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 13),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _oldPasswordController,
                          onSaved: (password) {
                            passwords["oldPassword"] = password;
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
                              border: OutlineInputBorder(),
                              labelText: "Old Password",
                              labelStyle: TextStyle(fontSize: 18),
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 13),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _newPasswordController,
                          onSaved: (password) {
                            passwords["newPassword"] = password;
                          },
                          onChanged: (password) {
                            print(password);
                            print("LENGTH ${password.length}");
                            setState(() {
                              //LENGTH
                              if (password.length >= 8) {
                                _isEight = true;
                              }
                              if (password.length < 8) {
                                _isEight = false;
                              }
                              if (password.contains(RegExp(r"[A-Z]"))) {
                                _isUpperCase = true;
                              }
                              if (!password.contains(RegExp(r"[A-Z]"))) {
                                _isUpperCase = false;
                              }
                              if (password.contains(RegExp(r"[0-9]"))) {
                                _isNumber = true;
                              }
                              if (!password.contains(RegExp(r"[0-9]"))) {
                                _isNumber = false;
                              }
                              if (password.contains(
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>/]'))) {
                                _isSpecialChar = true;
                              }
                              if (!password.contains(
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>/]'))) {
                                _isSpecialChar = false;
                              }
                            });
                          },
                          validator: (password) {
                            //  if(isLength())
                            if (password.length < 8 ||
                                password.isEmpty ||
                                !password.contains(RegExp(r"[a-z]")) ||
                                !password.contains(RegExp(r"[A-Z]")) ||
                                !password.contains(RegExp(r"[0-9]")) ||
                                !password.contains(
                                    RegExp(r'[!@#$%^&*(),?":{}|<>/]'))) {
                              return "Please follow the password instructions";
                            } else {
                              return null;
                            }
                          },
                          obscureText: isVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "New Password",
                              labelStyle: TextStyle(fontSize: 18),
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            _isEight
                                ? Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Colors.green[600],
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red[600],
                                  ),
                            Text(" at least 8 characters")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            _isUpperCase
                                ? Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Colors.green[600],
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red[600],
                                  ),
                            Text(" uppercase character")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            _isSpecialChar
                                ? Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Colors.green[600],
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red[600],
                                  ),
                            Text(" at least 1 special character")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            _isNumber
                                ? Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Colors.green[600],
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red[600],
                                  ),
                            Text(" at least 1 number")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 13),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: _confirmPasswordController,
                          onSaved: (cPassword) {
                            passwords["confirmPassword"] = cPassword;
                          },
                          validator: (cPassword) {
                            //  if(isLength())
                            if (cPassword != _newPasswordController.text) {
                              return "Password does not match";
                            } else {
                              return null;
                            }
                          },
                          obscureText: isVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Confirm password",
                              labelStyle: TextStyle(fontSize: 18),
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.maxFinite,
                        // margin: EdgeInsets.symmetric(horizontal: 6),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(vertical: 18),
                          onPressed: _submit,
                          child: Text(
                            'Change password',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
