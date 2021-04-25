import 'package:equal_cash/screens/currency_buy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencySellWidget extends StatefulWidget {
  @override
  _CurrencySellWidgetState createState() => _CurrencySellWidgetState();
}

class _CurrencySellWidgetState extends State<CurrencySellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "What currency would you like to sell?",
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
            onTap: () => Navigator.of(context).pushNamed(CurrencyBuy.routeName),
            leading: Image.asset('assets/images/niger_icon.png'),
            title: Text("NGN Nigerian Naira"),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushNamed(CurrencyBuy.routeName),
            leading: Image.asset('assets/images/usicon.png'),
            title: Text("USD US Dollars"),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushNamed(CurrencyBuy.routeName),
            leading: Image.asset('assets/images/ghanaicon.png'),
            title: Text("GHS Ghana Cedis"),
          ),
        ],
      ),
    );
  }
}
