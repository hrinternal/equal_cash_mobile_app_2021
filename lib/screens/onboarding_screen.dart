import 'package:equal_cash/models/onboarding_models.dart';
import 'package:equal_cash/screens/login_screen.dart';
import 'package:equal_cash/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboarding";
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    print("SCREEN HEIGHT ${MediaQuery.of(context).size.height}");
    print("SCREEN WIDTH ${MediaQuery.of(context).size.width}");

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              //SLIDERS
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: Colors.amber,
                        child: Image.asset(
                          "assets/images/logo1.png",
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemCount: onboardingItems.length,
                            itemBuilder: (_, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //HINT
                                  Hint(index),
                                  //IMAGE
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    child: Image.asset(
                                      onboardingItems[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  //DETAILS
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      width: double.maxFinite,
                                      child: Text(
                                        onboardingItems[index].details,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height >=
                                                  600
                                              ? 15
                                              : 12,
                                          color: Theme.of(context).accentColor,
                                        ),
                                      )),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //DOTS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(onboardingItems.length, (dotCount) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 3, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: dotCount == currentIndex
                                  ? Color.fromRGBO(121, 128, 235, 1)
                                  : Color.fromRGBO(196, 196, 196, 1),
                            ),
                            height: 10,
                            width: 10,
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
              //REGISTRATION AND LOGIN BUTTONS
              RegistrationLoginButtons()
            ],
          )),
    );
  }
}

//HINT
class Hint extends StatelessWidget {
  final int index;
  const Hint(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 39),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: onboardingItems[index].hint,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.height >= 600 ? 20 : 15,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: onboardingItems[index].coloredHint,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.height >= 600 ? 20 : 15,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: onboardingItems[index].hint2,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.height >= 600 ? 20 : 15,
                  fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}

//REGISTRATION AND LOGIN BUTTONS
class RegistrationLoginButtons extends StatelessWidget {
  const RegistrationLoginButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: ),
      height: MediaQuery.of(context).size.height * 0.23,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //REGISTRATION
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(vertical: 18),
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.routeName);
              },
              child: Text(
                'REGISTER',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          //LOGIN
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2)),
              padding: EdgeInsets.symmetric(vertical: 18),
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
