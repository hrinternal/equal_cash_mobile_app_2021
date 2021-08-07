import 'package:equal_cash/controllers/transaction.dart';
import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pending_transactions.dart';

class CompletedTransaction extends StatefulWidget {
  static const routeName = "completed-transaction-screen";

  @override
  _CompletedTransactionState createState() => _CompletedTransactionState();
}

class _CompletedTransactionState extends State<CompletedTransaction> {
  @override
  Widget build(BuildContext context) {
    final requests = Provider.of<TransactionsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Completed transactions",
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
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transaction as a buyer",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 6,
                child: Container(
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
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 32,
                child: TransactionBody(
                  controller: (userId) =>
                      CompletedTransactionController(userId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
