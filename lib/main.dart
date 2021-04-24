import 'package:equal_cash/screens/auth_confirmation_screen.dart';
import 'package:equal_cash/screens/confirm_pin_screen.dart';
import 'package:equal_cash/screens/create_pin_screen.dart';
import 'package:equal_cash/screens/forgot_password.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/login_screen.dart';
import 'package:equal_cash/screens/onboarding_screen.dart';
import 'package:equal_cash/screens/registration_screen.dart';
import 'package:equal_cash/screens/reset_password_screen.dart';
import 'package:equal_cash/screens/splash_screen.dart';
import 'package:equal_cash/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Poppins",
          primaryColor: Color.fromRGBO(14, 129, 59, 1),
          accentColor: Colors.black,
          backgroundColor: Colors.white),
      home: SplashScreen(),
      routes: {
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        RegistrationScreen.routeName: (_) => RegistrationScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        CreatePinScreen.routeName: (_) => CreatePinScreen(),
        ConfirmPinScreen.routeName: (_) => ConfirmPinScreen(),
        ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
        AuthConfirmationScreen.routeName: (_) => AuthConfirmationScreen(),
        ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        UpdateProfileScreen.routeName: (_) => UpdateProfileScreen()
      },
    );
  }
}
