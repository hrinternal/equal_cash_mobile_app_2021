// import 'dart:html';

import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/models/api/request.dart';
import 'package:equal_cash/models/currency_model.dart';
import 'package:equal_cash/pref.dart';
import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/my_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ConfirmCurrencyPurchase extends StatefulWidget {
  static const routeName = "currency-confirm";

  @override
  _ConfirmCurrencyPurchaseState createState() =>
      _ConfirmCurrencyPurchaseState();
}

class _ConfirmCurrencyPurchaseState extends State<ConfirmCurrencyPurchase> {
  final rateController = TextEditingController();
  final amountController = TextEditingController();
  final timeController = TextEditingController();
  double rate = 0.0;

  Future initateRequest() async {
    String? userId = await Settings.instance.userId;

    var amount = amountController.text;
    var rate = rateController.text;
    var timeFrame = timeController.text;
    var initRequestParam = InitRequestParam(
            userId: userId,
            amount: amount,
            baseCurrency: selectedCurrencies[CSELL],
            quoteCurrency: selectedCurrencies[CBUY],
            rate: rate,
            reference: "",
            timeFrame: timeFrame);
    ApiRepository()
        .initiateRequest(initRequestParam)
        .then((value) {
      print("${initRequestParam.toJson()}");
      var message = value.response!.message;
      print("$message");
      if (value.response!.status==200) {
        successAction();
      }else{
        Get.snackbar("",message!);
      }
    });
  }

  void successAction() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              "Request created",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green[900]),
            ),
            content: Text(
              "Request created successfully.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        });

    firstTime = 0;

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return MyRequestScreen();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final getAmountReceived = Provider.of<TransactionsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm currency",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sell",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Container(
                          // color: Colors.amber,
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                selectedCurrencies['cSell'],
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.network(selectedCurrencies["cSellImg"])
                              // Image.asset("assets/images/usicon.png")
                            ],
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "Buy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Container(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                selectedCurrencies['cBuy'],
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // Image.asset("assets/images/niger_icon.png")
                              Image.network(selectedCurrencies["cBuyImg"])
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(12),
                width: deviceWidth * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Color.fromRGBO(13, 131, 60, 1),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "You send",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: amountController,
                            decoration: InputDecoration(
                                hintText: "Amount to send",
                                hintStyle: TextStyle(fontSize: 13),
                                prefixIcon: Icon(
                                  Icons.send,
                                  color: Theme.of(context).primaryColor,
                                )),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Spacer(),
                        Container(
                            width: 70,
                            child: Row(children: [
                              Image.network(selectedCurrencies["cSellImg"]),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                selectedCurrencies["cSell"],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ]))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(12),
                width: deviceWidth * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Color.fromRGBO(13, 131, 60, 1),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "They receive",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          rate.toString() == "0.0"
                              ? "0.00"
                              : rate.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(14, 129, 59, 1)),
                        ),
                        Spacer(),
                        Container(
                            width: 70,
                            child: Row(children: [
                              Image.network(selectedCurrencies["cBuyImg"]),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                selectedCurrencies["cBuy"],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ]))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //CURRENCY RATE
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  height: 30,
                  child: TextFormField(
                    onChanged: (userRate) {
                      print(userRate);
                      setState(() {
                        var amountEntered = amountController.text;
                        rate = double.parse(amountEntered) /
                            double.parse(userRate);
                      });
                    },
                    controller: rateController,
                    decoration: InputDecoration(
                        hintText: "Exchange rate",
                        hintStyle: TextStyle(fontSize: 13),
                        prefixIcon: Icon(
                          Icons.rate_review_rounded,
                          color: Theme.of(context).primaryColor,
                        )),
                    keyboardType: TextInputType.number,
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Please enter your rate here")),
              SizedBox(
                height: 45,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: timeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Set time (in hours)",
                      hintStyle: TextStyle(fontSize: 13),
                      suffixIcon: Icon(Icons.timer)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: deviceWidth * 0.84,
                decoration: BoxDecoration(),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Color.fromRGBO(14, 129, 59, 1),
                  onPressed: () {
                    rateController.text.isEmpty ||
                            amountController.text.isEmpty ||
                            timeController.text.isEmpty
                        ? showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                actions: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.red[900],
                                      ),
                                      onPressed: () => Navigator.pop(context))
                                ],
                                title: Text(
                                  "Invalid transaction",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Please ensure you enter ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'Amount ',
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'to send, ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'Exchange rate, ',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'and, ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'Time frame.',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold)),
                                ])),
                              );
                            })
                        : showDialog(
                            context: context,
                            builder: (_) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: AlertDialog(
                                  title: Row(
                                    children: [
                                      Text(
                                        "Sell request summary",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.red[900],
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop())
                                    ],
                                  ),
                                  content: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: Text("From"),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                selectedCurrencies['cSell'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(amountController.text,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 4,
                                              ),

                                              Image.network(
                                                selectedCurrencies["cSellImg"],
                                                width: 17,
                                                height: 17,
                                              ),
                                              // Image.asset("assets/images/usicon.png")
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          title: Text("To"),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                selectedCurrencies['cBuy'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(rate.toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 4,
                                              ),

                                              Image.network(
                                                selectedCurrencies["cBuyImg"],
                                                width: 17,
                                                height: 17,
                                              ),
                                              // Image.asset("assets/images/usicon.png")
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          title: Text("Rate"),
                                          trailing: Text(
                                            selectedCurrencies['cSell'] +
                                                rate.toStringAsFixed(2) +
                                                "/ ${selectedCurrencies['cBuy']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    121, 128, 235, 1)),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text("Time frame"),
                                          trailing: Text(
                                            timeController.text + "hrs",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    121, 128, 235, 1)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          // margin: EdgeInsets.symmetric(horizontal: 20),
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 13),
                                            onPressed: initateRequest,
                                            // Navigator.of(context)
                                            //     .pushNamed(SaveProfileScreen.routeName);

                                            child: Text(
                                              'Create request',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                  },
                  child: Text(
                    "Done >",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
