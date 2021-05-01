import 'package:equal_cash/providers/auth_provider.dart';
import 'package:equal_cash/providers/recent_activities_provider.dart';
import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/all_requests.dart';
import 'package:equal_cash/screens/auth_confirmation_screen.dart';
import 'package:equal_cash/screens/change_password_screen.dart';
import 'package:equal_cash/screens/completed_transactions.dart';
import 'package:equal_cash/screens/confirm_currency_buy.dart';
import 'package:equal_cash/screens/confirm_pin_screen.dart';
import 'package:equal_cash/screens/create_pin_screen.dart';
import 'package:equal_cash/screens/currency_buy.dart';
import 'package:equal_cash/screens/currency_sell_request_screen.dart';
import 'package:equal_cash/screens/forgot_password.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/login_screen.dart';
import 'package:equal_cash/screens/my_request_screen.dart';
import 'package:equal_cash/screens/notification_screen.dart';
import 'package:equal_cash/screens/onboarding_screen.dart';
import 'package:equal_cash/screens/pending_transactions.dart';
import 'package:equal_cash/screens/registration_screen.dart';
import 'package:equal_cash/screens/reset_forgot_password.dart';
import 'package:equal_cash/screens/reset_password_screen.dart';
import 'package:equal_cash/screens/save_profile_screen.dart';
import 'package:equal_cash/screens/settings_screen.dart';
import 'package:equal_cash/screens/splash_screen.dart';
import 'package:equal_cash/screens/update_profile_screen.dart';
import 'package:equal_cash/screens/updated_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        // ChangeNotifierProvider.value(value: RecentActivitiesProvider())
        ChangeNotifierProvider(
          create: (_) => RecentActivitiesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionsProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "Poppins",
            primaryColor: Color.fromRGBO(14, 129, 59, 1),
            accentColor: Color.fromRGBO(68, 51, 255, 1),
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
          UpdateProfileScreen.routeName: (_) => UpdateProfileScreen(),
          SaveProfileScreen.routeName: (_) => SaveProfileScreen(),
          UpdatedProfileScreen.routeName: (_) => UpdatedProfileScreen(),
          CurrencySellRequestScreen.routeName: (_) =>
              CurrencySellRequestScreen(),
          SettingsScreen.routeName: (_) => SettingsScreen(),
          ChangePasswordScreen.routeName: (_) => ChangePasswordScreen(),
          NotificationScreen.routeName: (_) => NotificationScreen(),
          ConfirmCurrencyPurchase.routeName: (_) => ConfirmCurrencyPurchase(),
          CurrencyBuy.routeName: (_) => CurrencyBuy(),
          MyRequestScreen.routeName: (_) => MyRequestScreen(),
          AllRequestScreen.routeName: (_) => AllRequestScreen(),
          PendingTransaction.routeName: (_) => PendingTransaction(),
          CompletedTransaction.routeName: (_) => CompletedTransaction(),
          ResetForgotPasswordScreen.routeName: (_) =>
              ResetForgotPasswordScreen(),
        },
      ),
    );
  }
}
