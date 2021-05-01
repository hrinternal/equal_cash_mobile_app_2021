// import 'dart:html';

import 'dart:convert';

import 'package:equal_cash/screens/currency_buy.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Currencies {
  final int id;
  final String cName;
  final String cSym;

  Currencies(this.id, this.cName, this.cSym);
}

class TransactionsProvider with ChangeNotifier {
  int c = 0;

  List _currencies = [];

  List get getAllCurrencies {
    return [..._currencies].toSet().toList();
  }

  int get allCurrencyLength {
    return getAllCurrencies.length;
  }

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
}
