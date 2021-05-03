// import 'dart:html';

import 'dart:convert';

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
  int c = 0;
  int d = 0;

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
    c++;

    List items = data["response"]["data"];

    if (c == 1) {
      _currencies.addAll(items);
    } else {}

    print("ELEMENTS $_currencies");
    // _currencies.addAll(data["response"]["data"]);
    print("DATA ${data["response"]["data"]}");
    print(response.body);
  }

  //ALL REQUEST
  Future getAllRequests() async {
    final url =
        "https://peer-to-peer.staging.cloudware.ng/api/get_all_requests.php";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    d++;

    List items = data["response"]["data"];

    print("ALL DATA REQUESTS $data");

    if (d == 1) {
      // _currencies.addAll(items);
    } else {}

    print("ELEMENTS $_currencies");
    // _currencies.addAll(data["response"]["data"]);
    print("DATA REQUEST ${data["response"]}");
    print(response.body);
  }

//USER REQUEST
  Future getUserRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("userId");

    final url =
        "https://peer-to-peer.staging.cloudware.ng/api/get_request_by_user_id.php?user_id=$userId";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    d++;

    // List items = data["response"]["data"];

    print("USER DATA REQUESTS $data");

    if (d == 1) {
      // _currencies.addAll(items);
    } else {}

    print("ELEMENTS $_currencies");
    // _currencies.addAll(data["response"]["data"]);
    print("DATA REQUEST ${data["response"]}");
    print(response.body);
  }

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

    // d++;

    // List items = data["response"]["data"];

    print("TRANS BUY DATA REQUESTS $data");

    if (d == 1) {
      // _currencies.addAll(items);
    } else {}

    print("BUY $_currencies");
    // _currencies.addAll(data["response"]["data"]);
    print("DATA BUY ${data["response"]}");
    print(response.body);
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

    if (d == 1) {
      // _currencies.addAll(items);
    } else {}

    pendingTrans.addAll(data['response']['data']);

    // _currencies.addAll(data["response"]["data"]);
    print("PENDING BUY ${data["response"]}");
    print(response.body);
  }
}
