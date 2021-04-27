import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  Future<Void> register(
      String country,
      String firstname,
      String lastname,
      String email,
      String phonenumber,
      String password,
      String confirmPasssword,
      bool terms) async {
    final url = "http://peertopeer.staging.cloudware.ng/api/registration.php";
    final response = await http.post(Uri.parse(url), body: {
      "firs_tname": firstname,
      "last_name": lastname,
      "phone": phonenumber,
      "email": email,
      "password": password,
      "country": country,
      "confirm_password": confirmPasssword,
      "terms_condition": terms
    });

    print("RESPONSE $response");
    print("RESPONSE BODY ${response.body}");
    print("STATUS CODE ${response.statusCode}");
  }
}
