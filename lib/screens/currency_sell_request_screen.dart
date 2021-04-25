import 'package:flutter/material.dart';

class CurrencySellRequestScreen extends StatefulWidget {
  static const String routeName = "currency-sell-request";
  @override
  _CurrencySellRequestScreenState createState() =>
      _CurrencySellRequestScreenState();
}

class _CurrencySellRequestScreenState extends State<CurrencySellRequestScreen> {
  String currencySelected = "NGN Nigerian Naira";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request sell",
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Currency sell requests",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose the currency for which you want to get alert",
                style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                decoration: BoxDecoration(border: Border.all()),
                // height: 100,
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.maxFinite,
                // color: Colors.amber,
                child: DropdownButton<String>(
                  value: currencySelected,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.deepPurpleAccent,
                  // ),
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      currencySelected = newValue;
                    });
                  },
                  items: <String>[
                    'NGN Nigerian Naira',
                    'USD US Dollars',
                    'GHS Ghana Cedis'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ))
          ],
        ),
      ),
    );
  }
}
