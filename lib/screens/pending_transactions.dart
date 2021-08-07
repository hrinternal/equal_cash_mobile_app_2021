import 'package:equal_cash/controllers/transaction.dart';
import 'package:equal_cash/models/api/transaction.dart';
import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../pref.dart';
import 'completed_transactions.dart';

class PendingTransaction extends StatefulWidget {
  static const routeName = "pending-transaction-screen";

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
                    "Pending transaction as a buyer",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                height: 0,
              ),
              Expanded(
                flex: 32,
                child: TransactionBody(
                  controller: (userId) => PendingTransController(userId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionBody<T extends GetxController> extends StatelessWidget {
  const TransactionBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final T Function(String userId) controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Settings.instance.userId,
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading!");
        } else {
          return GetBuilder<T>(
              init: controller(snapshot.data!),
              builder: (controller) {
                List<TransDataBean> requests = [];
                if (T == PendingTransController) {
                  requests = (controller as PendingTransController)
                          .pendingRequests
                          .value
                          .response
                          ?.data
                          ?.reversed
                          .toList() ??
                      [];
                } else {
                  requests = (controller as CompletedTransactionController)
                          .completedRequests
                          .value
                          .response
                          ?.data
                          ?.reversed
                          .toList() ??
                      [];
                }
                requests.forEach((element) {
                  print(element.toJson());
                });

                if (requests.isEmpty) {
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
                  return TransListWidget(requests: requests);
                }
              });
        }
      },
    );
  }
}

class TransListWidget extends StatelessWidget {
  const TransListWidget({
    Key? key,
    required this.requests,
  }) : super(key: key);

  final List<TransDataBean> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: requests.length,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var request = requests[index];
        var isPaymentComplete = request.status == "Payment Confirmed";
        var indicatorColor =
            isPaymentComplete ? Color.fromARGB(255, 13, 183, 83) : Colors.grey;
        return Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.circle,
                color: indicatorColor,
                size: 10,
              ),
            ),
            Expanded(
              flex: 15,
              child: Column(children: [
                Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(request.currency_from_flag ?? ""),
                          ),
                        )),
                    Expanded(
                      flex: 9,
                      child: ListTile(
                        title: Text(
                          // "\$100 USD - NGN Naira",
                          // "${request.amount} ${request.currency_from} - ${request.currency_to}",
                          "${request.amount}"
                          " ${request.currency_from}",
                          style: TextStyle(
                              color: isPaymentComplete
                                  ? Color.fromARGB(255, 121, 128, 235)
                                  : Color.fromARGB(255, 14, 129, 59),
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Container(
                          alignment: Alignment.centerLeft,
                          // color: Colors.green,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Seller - ${request.seller_id}"),
                              // Spacer(),
                              SizedBox(
                                height: 1,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 2),
                                color: indicatorColor,
                                child: Text("${request.status}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                        trailing: Container(
                          child: Icon(Icons.more_vert),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
              ]),
            ),
          ],
        );
      },
    );
  }
}
