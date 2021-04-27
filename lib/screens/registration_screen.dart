import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/providers/auth_provider.dart';
import 'package:equal_cash/screens/create_pin_screen.dart';
import 'package:equal_cash/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:string_validator/string_validator.dart' as validator;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "registration";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String country;

  //TEXT CONTROLLERS
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //SAVED DATA
  Map<String, dynamic> savedData = {
    "country": "Nigeria",
    "firstname": "",
    "lastname": "",
    "email": "",
    "password": "",
    "confirmPassword": "",
    "terms": false
  };

  //PASSWORD VISIBILITY
  bool isVisible = false;

  //TERMS
  bool isTerm = false;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (!isTerm) return;

    _formKey.currentState.save();

    try {
      await Provider.of<AuthProvider>(context, listen: false).register(
          savedData["country"],
          savedData["firstname"],
          savedData["lastname"],
          savedData["email"],
          savedData["email"],
          savedData["password"],
          savedData["confirmPassword"],
          savedData["terms"]);
      CircularProgressIndicator(
        strokeWidth: 5,
        semanticsLabel: "Registering ${_firstnameController.text}",
      );
      //ALERT
      Alert(
        style: AlertStyle(
          animationDuration: Duration(milliseconds: 500),
          animationType: AnimationType.grow,
          titleStyle:
              TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        // desc: error.message,

        title: "Registration successful",
        context: context,

        content: Text(
          "A verification link has beign sent to ${_emailController.text}. Please click the link to verify.",
          style: TextStyle(fontSize: 12),
        ),
        type: AlertType.info,
        image: Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.blue[900],
        ),
      ).show();
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      });
    } on HttpException catch (error) {
      Alert(
        style: AlertStyle(
          animationDuration: Duration(milliseconds: 400),
          animationType: AnimationType.fromTop,
          titleStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        // desc: error.message,
        title: "USER EXISTS",
        context: context,
        content: Text(error.message),
        type: AlertType.error,
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
          color: Colors.blue[900],
        ),
      ).show();
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    country = "Nigeria";
  }

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
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sign up for free!",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Country",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: deviceHeight >= 600 ? 18 : 14,
                                  color: Color.fromRGBO(88, 20, 235, 1)),
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight >= 600 ? 10 : 8,
                          ),
                          //COUNTRY
                          Container(
                            padding: EdgeInsets.all(0),
                            alignment: Alignment.centerLeft,
                            child: CountryCodePicker(
                              padding: EdgeInsets.all(0),
                              initialSelection: "NG",
                              showCountryOnly: true,
                              showOnlyCountryWhenClosed: true,
                              onChanged: (cCode) {
                                setState(() {
                                  savedData["country"] = cCode.name;
                                });
                                print(country);
                              },
                              flagDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          //FIRSTNAME
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _firstnameController,
                            onSaved: (fName) {
                              savedData["firstname"] = fName;
                            },
                            validator: (firstname) {
                              if (firstname.isEmpty) {
                                return "Please enter your first name";
                              } else if (!validator.isAlpha(firstname)) {
                                return "Please enter a valid first name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelText: "Firstname",
                                labelStyle: TextStyle(
                                    fontSize: deviceHeight >= 600 ? 18 : 14)),
                          ),
                          SizedBox(height: 10),
                          //LASTNAME
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _lastnameController,
                            onSaved: (lName) {
                              savedData["lastname"] = lName;
                            },
                            validator: (lastname) {
                              if (lastname.isEmpty) {
                                return "Please enter your last name";
                              } else if (!validator.isAlpha(lastname)) {
                                return "Please enter a valid first name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelText: "Lastname",
                                labelStyle: TextStyle(
                                    fontSize: deviceHeight >= 600 ? 18 : 14)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //LOGIN DETAILS
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     "Your login details",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: deviceHeight >= 600 ? 18 : 14,
                          //         color: Color.fromRGBO(88, 20, 235, 1)),
                          //   ),
                          // ),
                          //EMAIL
                          TextFormField(
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
                          SizedBox(
                            height: 20,
                          ),
                          //PHONE NUMBER
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            // onInputValidated: (bool value) {
                            //   print(value);
                            // },
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            // autoValidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            selectorTextStyle: TextStyle(color: Colors.black),
                            textFieldController: _phoneController,
                            formatInput: false,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            keyboardAction: TextInputAction.next,
                            // inputBorder: OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                              setState(() {
                                savedData["confirmPassword"] =
                                    number.toString();
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //PASSWORD
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _passwordController,
                            onSaved: (password) {
                              savedData["password"] = password;
                            },
                            validator: (password) {
                              //  if(isLength())
                              if (password.length < 8 ||
                                  password.isEmpty ||
                                  !password.contains(RegExp(r"[a-z]")) ||
                                  !password.contains(RegExp(r"[A-Z]")) ||
                                  !password.contains(RegExp(r"[0-9]")) ||
                                  !password.contains(
                                      RegExp(r'[!@#$%^&*(),.?":{}|<>/]'))) {
                                return "Please follow the password instructions";
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
                          SizedBox(
                            height: 5,
                          ),
                          //PASSWORD
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _confirmPasswordController,
                            onSaved: (cPassword) {
                              savedData["confirmPassword"] = cPassword;
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
                                labelText: "Confirm password",
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
                          SizedBox(
                            height: 5,
                          ),
                          //PASSWORD HINT
                          Container(
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                            "Your password should be at least "),
                                    TextSpan(
                                      text: "8 characters, ",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(88, 20, 235, 1)),
                                    ),
                                    TextSpan(
                                      text: "and include ",
                                    ),
                                    TextSpan(
                                      text:
                                          "1 upper case letter, 1 lower case letter ",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(88, 20, 235, 1)),
                                    ),
                                    TextSpan(text: "and "),
                                    TextSpan(
                                      text: "1 number and at least a character",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(88, 20, 235, 1)),
                                    )
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight >= 600 ? 15 : 5,
                          ),
                          // TERMS AND CONDITION
                          Container(
                            child: FlatButton.icon(
                                onPressed: () {
                                  setState(() {
                                    isTerm = !isTerm;
                                    savedData["terms"] = isTerm;
                                  });
                                },
                                icon: Icon(isTerm
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank_rounded),
                                label: Text(
                                    "I agree to the Terms and Conditions")),
                          ),

                          SizedBox(height: 10),
                          //REGISTER BUTTON
                          Container(
                            width: double.maxFinite,
                            // margin: EdgeInsets.symmetric(horizontal: 25),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(vertical: 18),
                              onPressed: _submit,
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: deviceHeight >= 600 ? 16 : 14),
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
