import 'dart:html';

import 'package:flutter/material.dart';

class SellWidget extends StatefulWidget {
  @override
  _SellWidgetState createState() => _SellWidgetState();
}

class _SellWidgetState extends State<SellWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Sell",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        width: 70,
                        child: Row(
                          children: [
                            Text("USD"),
                            Image.asset("assets/images/usicon.png")
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Buy",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        width: 70,
                        child: Row(
                          children: [
                            Text("NGN"),
                            Image.asset("assets/images/niger_icon.png")
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            //CURRENCY RATE
            Container(
              height: 100,
              child: Row(
                children: [
                  Icon(Icons.swap_vert_rounded),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "1 USD - "),
                      TextSpan(text: "480 NGN"),
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: deviceWidth * 0.8,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Color.fromRGBO(13, 131, 60, 1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "You send",
                    style: TextStyle(fontSize: 18),
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
                            Text("USD"),
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
              width: deviceWidth * 0.8,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Color.fromRGBO(13, 131, 60, 1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "They receive",
                    style: TextStyle(fontSize: 18),
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
                            Text("USD"),
                          ]))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Set time (in hours)",
                  suffixIcon: Icon(Icons.timer)),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: FlatButton(
                color: Color.fromRGBO(14, 129, 59, 1),
                onPressed: () {},
                child: Text(
                  "Done >",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
