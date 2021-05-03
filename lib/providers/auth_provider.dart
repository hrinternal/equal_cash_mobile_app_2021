import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:equal_cash/models/http_exception.dart';
import 'package:equal_cash/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String userId;

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
        throw HttpException("This user already exist!!!", 105);
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
    final url = "https://peertopeer.staging.cloudware.ng/api/authenticate.php";
    try {
      final response = await http
          .post(Uri.parse(url), body: {"email": email, "password": password});
      final responseBody = jsonDecode(response.body);

      int status = responseBody['response']['status'];
      print(status);

      if (responseBody['response']['status'] == 105) {
        throw HttpException("Incorrect email or password", 105);
      } else if (responseBody['response']['status'] == 107) {
        throw HttpException(
            "Your account has not been activated, please check your mail for the confirmation message.",
            107);
      }

      Map<dynamic, dynamic> data = responseBody['response']['data'];
      String userId = data["unique_id"];
      String fullname = data["fullname"];

      SharedPreferences saveUserId = await SharedPreferences.getInstance();
      await saveUserId.setString("userId", userId);
      await saveUserId.setString("fullname", fullname);

      print(fullname);
      print("RESPONSE DATA $data");
      print("USER ID $userId");
      print(response);
      print(responseBody);
    } catch (error) {
      throw error;
    }
  }

  //RESET PASSWORD
  Future<void> resetPassword(String email) async {
    String url =
        "https://peertopeer.staging.cloudware.ng/api/forgot_password.php";

    try {
      final response = await http.post(Uri.parse(url), body: {
        "email": email,
      });

      final responseBody = jsonDecode(response.body);

      if (responseBody["response"]["status"] == 105) {
        throw HttpException("This user does not exist!!!", 105);
      }

      print(responseBody);
    } catch (error) {
      throw error;
    }
    // print(responseBody)
  }

  String get getUserId {
    return userId;
  }

  //CREATE PASSWORD
  Future<void> createNewPassword(String oldPassword, String newPassword,
      String confirmPassword, String userId) async {
    final url =
        "https://peertopeer.staging.cloudware.ng/api/change_password.php";
    try {
      final response = await http.post(Uri.parse(url), body: {
        "password": newPassword,
        "confirm_password": confirmPassword,
        "old_password": oldPassword,
        "user_id": userId
      });

      final responseBody = jsonDecode(response.body);

      if (responseBody['response']['status'] == 106) {
        throw HttpException(
            'The old password is incorrect. Please try again!!!', 106);
      }

      print("RESPONSE BODY $responseBody");
    } catch (error) {
      throw error;
    }
  }

  //UPDATE PROFILE
  Future<void> updateProfile(String address, String gender) async {
    final url =
        "https://peertopeer.staging.cloudware.ng/api/update_profile.php";

    SharedPreferences myId = await SharedPreferences.getInstance();
    String myIdee = myId.getString("userId");

    print("IDEE $myIdee");

// //pics.toString()
    //POST FOR GENDER AND ADDRESS
    final response = await http.post(Uri.parse(url),
        body: {"gender": gender, "user_id": myIdee, "address": address});

    // final picRes = jsonDecode(picResponse.body);

    final responseBody = jsonDecode(response.body);

    print("STATUS CODE ${response.statusCode}");

    // if (picRes['response']['status'] == 107) {
    //   throw HttpException(picRes['response']['message'], 107);
    // }

    // if (responseBody['response']['status'] == 106) {
    //   throw HttpException(
    //       'The old password is incorrect. Please try again!!!', 106);
    // }
    // print("PIC RESPONSE $picRes");
    print("RESPONSE BODY ADDRESS $responseBody");
    // }
    // catch (error) {
    //   throw error;
    // }
  }

//UPLOAD IMAGE
  Future<void> uploadImage(File pic) async {
    SharedPreferences myId = await SharedPreferences.getInstance();
    String myIdee = myId.getString("userId");

    print("IDEE $myIdee");

    final urlPic =
        "https://peertopeer.staging.cloudware.ng/api/upload_profile_pic.php";

    // final picResponse = await http.post(Uri.parse(urlPic),
    //     body: jsonEncode(
    //         {"user_id": myIdee, "file": base64Encode(pic.readAsBytesSync())}));

    // final resBody = jsonDecode(picResponse.body);

    // print("PIC RESPONSE BODY $resBody");
    // print("PRINT STATUS CODE ${picResponse.statusCode}");

    // print("PIC RESPONSE $picResponse");
  }

  //GET IMAGE
  String profilePic = "";

  String get getProfilePic {
    return profilePic;
  }

  //GET PROFILE IMAGE
  Future getImage() async {
    SharedPreferences myId = await SharedPreferences.getInstance();
    String myIdee = myId.getString("userId");

    print("IDEE $myIdee");

    final url =
        "https://peertopeer.staging.cloudware.ng/api/get_profile_pic.php?user_id=$myIdee";

    final response = await http.get(Uri.parse(url));

    final getPicResponse = jsonDecode(response.body);

    profilePic = getPicResponse['response']['data']['profile_pic'];

    print("PIC RETRIEVE RESPONSE $getPicResponse");
    print(
        "PIC RETRIEVE RESPONSE ${getPicResponse['response']['data']['profile_pic']}");
  }
}
