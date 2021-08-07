import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:equal_cash/screens/my_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AllRequestScreen extends StatefulWidget {
  static const routeName = "all-request-screen";

  @override
  _AllRequestScreenState createState() => _AllRequestScreenState();
}

class _AllRequestScreenState extends State<AllRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final requests = Provider.of<TransactionsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Requests",
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
                    "From people all over the world",
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
                  future: requests.getAllRequests(),
                  // initialData: InitialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text(
                            "Loading all requests!!!",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ));
                    } else {
                      if (requests.getAllRequest.isEmpty) {
                        return Container(
                          child: Column(children: [
                            Center(
                                child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      height: 150,
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
                                            fontSize: 40)),
                                    TextSpan(
                                        text: 'request(s) yet!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22))
                                  ]))
                                ],
                              ),
                            ))
                          ]),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: requests.getAllRequest.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: AlertDialogWidget(
                                                  data: requests
                                                      .getAllRequest[index],
                                                  options: "all"),
                                            );
                                          });
                                    },
                                    leading: Icon(
                                      Icons.circle,
                                      size: 10,
                                    ),
                                    title: Text(
                                      "${requests.getAllRequest[index]['amount']} ${requests.getAllRequest[index]['base_currency']} - ${requests.getAllRequest[index]['quote_currency']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Container(
                                      alignment: Alignment.centerLeft,
                                      // color: Colors.green,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Time frame -  ${requests.getAllRequest[index]['time_frame']}hr"),
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    trailing: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Icon(Icons.more_vert),

                                          Text(
                                            requests.getAllRequest[index]
                                                ['date_created'],
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    121, 128, 235, 1)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                ],
                              );
                            });
                      }
                    }
                  },
                ),

                SizedBox(height: 70),
                // Spacer(),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "What do the colored dots mean?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(121, 128, 235, 1)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AllRequestAction { accept, counter }

Future<void> showAllRequestOptions(
    {required Function(AllRequestAction action) onClick}) async {
  switch (await showDialog<AllRequestAction>(
      context: Get.context!,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select an Action'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, AllRequestAction.accept);
              },
              child: const Text('Accept Offer'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, AllRequestAction.counter);
              },
              child: const Text('Counter Offer'),
            ),
          ],
        );
      })) {
    case AllRequestAction.accept:
      onClick(AllRequestAction.accept);
      break;
    case AllRequestAction.counter:
      onClick(AllRequestAction.counter);
      break;
    case null:
      // dialog dismissed
      break;
  }
}

