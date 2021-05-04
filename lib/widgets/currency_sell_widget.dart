import 'package:equal_cash/models/currency_model.dart';
import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/currency_buy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySellWidget extends StatefulWidget {
  @override
  _CurrencySellWidgetState createState() => _CurrencySellWidgetState();
}

class _CurrencySellWidgetState extends State<CurrencySellWidget> {
  @override
  Widget build(BuildContext context) {
    final currencies = Provider.of<TransactionsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
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
            FutureBuilder(
                future: currencies.getCurrencies(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Loading currencies",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    );
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
                                onTap: () {
                                  selectedCurrencies.update(
                                      "cSell",
                                      (value) =>
                                          currencies.getAllCurrencies[index]
                                              ['currency_symbol']);
                                  selectedCurrencies.update(
                                      "cSellImg",
                                      (value) =>
                                          currencies.getAllCurrencies[index]
                                              ['currency_image']);
                                  print(selectedCurrencies['cSell']);
                                  Navigator.of(context)
                                      .pushNamed(CurrencyBuy.routeName);
                                },
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    currencies.getAllCurrencies[index]
                                        ['currency_image'],
                                    fit: BoxFit.fitHeight,
                                  ),
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
    );
  }
}
