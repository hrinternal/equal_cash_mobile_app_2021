import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingTransaction extends StatefulWidget {
  static const routeName = "completed-transaction-screen";
  @override
  _PendingTransactionState createState() => _PendingTransactionState();
}

class _PendingTransactionState extends State<PendingTransaction> {
  @override
  Widget build(BuildContext context) {
    final requests = Provider.of<TransactionsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Pending transactions",
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
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pending transaction as a buyer",
                    style: TextStyle(
                        fontSize: 15,
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
                        hintText: "Enter keywords e.g USD",
                        hintStyle:
                            TextStyle(fontSize: 13, color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: requests.allPendingTrans(),
                  // initialData: InitialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (requests.getPendingTrans.isEmpty) {
                      return Container(
                        child: Column(children: [
                          Center(
                              child: Container(
                            child: Column(
                              children: [
                                Container(
                                    height: 150,
                                    // color: Colors.red,
                                    child: Image.asset(
                                      'assets/images/emptybox.png',
                                      fit: BoxFit.cover,
                                    )),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'No ',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45)),
                                  TextSpan(
                                      text: 'pending transaction yet!',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ]))
                              ],
                            ),
                          ))
                        ]),
                      );
                    } else {
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 10,
                            ),
                            title: Text(
                              "\$100 USD - NGN Naira",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.green,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Time frame - 1 hour"),
                                  // Spacer(),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    color: Colors.grey,
                                    child: Text(
                                      "No offers yet",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Container(
                              child: Column(
                                children: [
                                  Icon(Icons.more_vert),
                                  Spacer(),
                                  Text(
                                    "now",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(121, 128, 235, 1)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            leading: Icon(Icons.circle,
                                size: 10,
                                color: Theme.of(context).primaryColor),
                            title: Text(
                              "\$500,000 NGN - USD Dollars",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.green,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Time frame - 1 hour"),
                                  // Spacer(),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    color: Theme.of(context).primaryColor,
                                    child: Text(
                                      "3 Offers",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Container(
                              child: Column(
                                children: [
                                  Icon(Icons.more_vert),
                                  Spacer(),
                                  Text(
                                    "10h ago",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(121, 128, 235, 1)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 10,
                              color: Color.fromRGBO(255, 72, 97, 1),
                            ),
                            title: Text(
                              "c1000 GHC - NGN Naira",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.green,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Time frame - 1 hour"),
                                  // Spacer(),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    color: Color.fromRGBO(255, 72, 97, 1),
                                    child: Text(
                                      "Expired - 0 Offers",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Container(
                              child: Column(
                                children: [
                                  Icon(Icons.more_vert),
                                  Spacer(),
                                  Text(
                                    "1d ago",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(121, 128, 235, 1)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
