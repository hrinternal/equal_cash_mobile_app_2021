// import 'dart:html';

import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ConfirmCurrencyPurchase extends StatefulWidget {
  static const routeName = "currency-confirm";
  @override
  _ConfirmCurrencyPurchaseState createState() =>
      _ConfirmCurrencyPurchaseState();
}

class _ConfirmCurrencyPurchaseState extends State<ConfirmCurrencyPurchase> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
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
                            children: [
                              Text(
                                "USD",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset("assets/images/usicon.png")
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
                            children: [
                              Text(
                                "NGN",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset("assets/images/niger_icon.png")
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
              //CURRENCY RATE
              Container(
                alignment: Alignment.center,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.swap_vert_rounded),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "1 USD - ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                        TextSpan(
                            text: "480 NGN",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ]),
                    ),
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
                        Text(
                          "0.00",
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(14, 129, 59, 1)),
                        ),
                        Spacer(),
                        Container(
                            width: 70,
                            child: Row(children: [
                              Image.asset("assets/images/usicon.png"),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "USD",
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
                          "0.00",
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(14, 129, 59, 1)),
                        ),
                        Spacer(),
                        Container(
                            width: 70,
                            child: Row(children: [
                              Image.asset("assets/images/niger_icon.png"),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "NGN",
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
                height: 45,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
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
                    showDialog(
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
                                        fontSize: 15),
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
                                      trailing: Text(
                                        "\$100USD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("To"),
                                      trailing: Text(
                                        "\N48,000",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("Exchange rate"),
                                      trailing: Text(
                                        "\$1USD - N480 NGN",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                121, 128, 235, 1)),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("Time frame"),
                                      trailing: Text(
                                        "24 Hrs",
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 13),
                                        onPressed: () {
                                          // Navigator.of(context)
                                          //     .pushNamed(SaveProfileScreen.routeName);
                                        },
                                        child: Text(
                                          'Create request',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        color: Theme.of(context).primaryColor,
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
