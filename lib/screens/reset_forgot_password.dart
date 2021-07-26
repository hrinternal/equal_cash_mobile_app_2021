import 'package:equal_cash/screens/auth_confirmation_screen.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ResetForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "reset-forgot-pass";
  @override
  _ResetForgotPasswordScreenState createState() =>
      _ResetForgotPasswordScreenState();
}

class _ResetForgotPasswordScreenState extends State<ResetForgotPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  Map<String, String> newPassword = {"password": "", "confirmPassword": ""};

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    SharedPreferences getUserId = await SharedPreferences.getInstance();
    print("GET ID ${getUserId.getString('userId')}");
    // await Provider.of<AuthProvider>(context, listen: false).createNewPassword(oldPassword, newPassword, confirmPassword, userId)
  }

  bool isVisible = false;

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Reset Password?",
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
                    "Create a new password",
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
                    "Choose a password that meats the criteria listed below",
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
                    "Enter new password",
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
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    onSaved: (password) {
                      newPassword["password"] = password;
                    },
                    validator: (password) {
                      //  if(isLength())
                      if (password.length < 8 ||
                          password.isEmpty ||
                          !password.contains(RegExp(r"[a-z]")) ||
                          !password.contains(RegExp(r"[A-Z]")) ||
                          !password.contains(RegExp(r"[0-9]")) ||
                          !password
                              .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>/]'))) {
                        return "Please follow the password instructions";
                      } else {
                        return null;
                      }
                    },
                    obscureText: isVisible,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
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
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _confirmPasswordController,
                    onSaved: (cPassword) {
                      newPassword["confirmPassword"] = cPassword;
                    },
                    validator: (cPassword) {
                      //  if(isLength())
                      if (cPassword != _passwordController.text) {
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.cancel_outlined,
                        color: Colors.red[600],
                      ),
                      Text(" at least 1 number")
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
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
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
