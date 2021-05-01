// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TransactionsProvider with ChangeNotifier {
  Future<void> getCurrencies() async {
    final url = "https://peertopeer.staging.cloudware.ng/api/get_currency.php";
    await http.get(Uri.parse(url));
  }
}
