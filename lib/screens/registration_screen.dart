import 'package:equal_cash/screens/create_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "registration";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey();
  String country;

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
                height: deviceHeight >= 600 ? 30 : 23,
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
                                  country = cCode.name;
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
                          //STATE
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "State",
                                labelStyle: TextStyle(
                                    fontSize: deviceHeight >= 600 ? 18 : 14)),
                          ),
                          SizedBox(
                            height: deviceHeight >= 600 ? 35 : 22,
                          ),
                          //LOGIN DETAILS
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your login details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: deviceHeight >= 600 ? 18 : 14,
                                  color: Color.fromRGBO(88, 20, 235, 1)),
                            ),
                          ),
                          //EMAIL
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    fontSize: deviceHeight >= 600 ? 18 : 14)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //PASSWORD
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    fontSize: deviceHeight >= 600 ? 18 : 14),
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () {})),
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
                                      text: "1 number",
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
                          //REFERRAL CODE
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Referral Code (optional)",
                                labelStyle: TextStyle(
                                    fontSize: deviceHeight >= 600 ? 18 : 14)),
                          ),
                          SizedBox(
                            height: deviceHeight >= 600 ? 50 : 40,
                          ),
                          //REGISTER BUTTON
                          Container(
                            width: double.maxFinite,
                            // margin: EdgeInsets.symmetric(horizontal: 25),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(vertical: 18),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(CreatePinScreen.routeName);
                              },
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
