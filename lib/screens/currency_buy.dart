import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/confirm_currency_buy.dart';
import 'package:equal_cash/screens/currency_sell_request_screen.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyBuy extends StatefulWidget {
  static const String routeName = "currency-buy";
  @override
  _CurrencyBuyState createState() => _CurrencyBuyState();
}

class _CurrencyBuyState extends State<CurrencyBuy> {
  @override
  Widget build(BuildContext context) {
    final currencies = Provider.of<TransactionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Currency Buy",
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
        child: SingleChildScrollView(
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
              FutureBuilder(
                  future: currencies.getCurrencies(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: currencies.allCurrencyLength,
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                Divider(
                                  thickness: 1,
                                ),
                                ListTile(
                                  onTap: () => Navigator.of(context).pushNamed(
                                      ConfirmCurrencyPurchase.routeName),
                                  leading: Icon(
                                    Icons.money,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: Text(currencies.getAllCurrencies[index]
                                      ['currency_name']),
                                  trailing: Text(
                                      currencies.getAllCurrencies[index]
                                          ['currency_symbol']),
                                ),
                              ],
                            );
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
