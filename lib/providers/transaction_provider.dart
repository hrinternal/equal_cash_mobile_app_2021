// import 'dart:html';

import 'dart:convert';

import 'package:equal_cash/models/currency_model.dart';
import 'package:equal_cash/screens/currency_buy.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Currencies {
  final int id;
  final String cName;
  final String cSym;

  Currencies(this.id, this.cName, this.cSym);
}

class TransactionsProvider with ChangeNotifier {
  List _currencies = [];

  List get getAllCurrencies {
    return [..._currencies].toSet().toList();
  }

  int get allCurrencyLength {
    return getAllCurrencies.length;
  }

//GET CURRENCIES
  Future getCurrencies() async {
    final url = "https://peertopeer.staging.cloudware.ng/api/get_currency.php";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    // data["data"];

    List items = data["response"]["data"];

    _currencies.addAll(items);

    print("ELEMENTS $_currencies");
    // _currencies.addAll(data["response"]["data"]);
    print("DATA ${data["response"]["data"]}");
    print(response.body);
  }

  //ALL REQUESTS
  List allRequests = [];

  List get getAllRequest {
    return [...allRequests];
  }

  //ALL REQUEST
  Future getAllRequests() async {
    final url =
        "https://peertopeer.staging.cloudware.ng/api/get_all_requests.php";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    allRequests = data["response"]["data"];

    print("ALL DATA REQUESTS $data");

    print("ELEMENTS $_currencies");

    print("ALL REQUEST ${data["response"]}");
    print(response.body);
  }

  //USER REQUESTS
  List userRequests = [];

  List get getUserRequests {
    return [...userRequests];
  }

  // int firstTime = 0;

  //GET BUYS
  List buys = [];

  //ADD BUYS
  List get getAddBuys {
    return [...buys];
  }

//Comlpeted Transaction Buy
  Future getCompTransBuy() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    final url =
        "https://peertopeer.staging.cloudware.ng/api/completed_transactions_buy.php?user_id=$userId";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
  }

  //PENDING TRANS
  List pendingTrans = [];

  //PENDING TRANS
  List get getPendingTrans {
    return [...pendingTrans];
  }

//Comlpeted Transaction Buy
  Future allPendingTrans() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    final url =
        "https://peertopeer.staging.cloudware.ng/api/ongoing_transactions.php?user_id=$userId";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    // d++;

    // List items = data["response"]["data"];

    print("PENDING DATA REQUESTS $data");

    pendingTrans.addAll(data['response']['data']);
  }

  //INITIATE REQUEST
  Future initiateRequest(String amount, String baseCurrency,
      String quoteCurrency, String rate, String timeReference) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    final url = "";
    final response = await http.post(Uri.parse(url), body: {
      "user_id": userId,
      "amount": amount,
      "base_currency": baseCurrency,
      "quote_currency": quoteCurrency,
      "rate": rate,
      "time_frame": timeReference
    });

    final responseBody = jsonDecode(response.body);
  }
}

class AuthProvider with ChangeNotifier {
//GET CURRENCIES
  Future register(
    String firstName,
    String lastName,
    String phone,
    String email,
    String password,
    String country,
    String confirmPassword,
    String termsCondition,
  ) async {
    final url = "http://peertopeer.staging.cloudware.ng/api/registration.php";
    final response = await http.post(Uri.parse(url), body: {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'password': password,
      'country': country,
      'confirm_password': confirmPassword,
      'terms_condition': termsCondition,
    });
    final data = jsonDecode(response.body);

    print("DATA ${data["response"]["data"]}");
    print(response.body);
  }
}
