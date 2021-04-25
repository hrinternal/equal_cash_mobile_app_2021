import 'package:equal_cash/screens/confirm_currency_buy.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyBuy extends StatefulWidget {
  static const String routeName = "currency-buy";
  @override
  _CurrencyBuyState createState() => _CurrencyBuyState();
}

class _CurrencyBuyState extends State<CurrencyBuy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select buy",
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home_rounded),
            onPressed: () =>
                Navigator.of(context).pushNamed(HomeScreen.routeName),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "What currency would you like to buy?",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 13, color: Colors.black)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(ConfirmCurrencyPurchase.routeName),
              leading: Image.asset('assets/images/niger_icon.png'),
              title: Text("NGN Nigerian Naira"),
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(ConfirmCurrencyPurchase.routeName),
              leading: Image.asset('assets/images/usicon.png'),
              title: Text("USD US Dollars"),
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(ConfirmCurrencyPurchase.routeName),
              leading: Image.asset('assets/images/ghanaicon.png'),
              title: Text("GHS Ghana Cedis"),
            ),
          ],
        ),
      ),
    );
  }
}
