import 'dart:convert';
import 'dart:ffi';
import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  //REGISTER
  Future<Void> register(
      String country,
      String firstname,
      String lastname,
      String email,
      String phonenumber,
      String password,
      String confirmPasssword,
      bool terms) async {
    final url = "https://peertopeer.staging.cloudware.ng/api/registration.php";
    String _termsAndCondition = terms.toString();
    try {
      final response = await http.post(Uri.parse(url), body: {
        "first_name": firstname,
        "last_name": lastname,
        "phone": phonenumber,
        "email": email,
        "password": password,
        "country": country,
        "confirm_password": confirmPasssword,
        "terms_condition": _termsAndCondition
      });

      print("RESPONSE $response");
      // serverResponse = response.body as Map<String, dynamic>;
      // print(serverResponse["response"]);

      final responseData = jsonDecode(response.body);

      final responseMessage = responseData['response']['status'];

      if (responseMessage == 105) {
        throw HttpException("This user already exist!!!");
      }

      print(responseMessage);
      print(serverResponse["response"]);
      print("RESPONSE2 $responseData");
      print("RESPONSE BODY ${response.body}");
      print("STATUS CODE ${response.statusCode}");
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //LOGIN
  Future<void> login(String email, String password) async {
    final url = "http://peertopeer.staging.cloudware.ng/api/authenticate.php";
    try {
      final response = await http
          .post(Uri.parse(url), body: {"email": email, "password": password});
      final responseBody = jsonDecode(response.body);
      print(response);
      print(responseBody);
    } catch (error) {}
  }
}
