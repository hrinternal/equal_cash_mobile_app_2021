import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MyRequestScreen extends StatefulWidget {
  static const routeName = "request-screen";
  @override
  _MyRequestScreenState createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Requests",
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
                    "Created by you",
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
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: AlertDialogWidget(),
                          );
                        });
                  },
                  leading: Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  title: Text(
                    "\$100 USD - NGN Naira",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
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
                              color: Color.fromRGBO(121, 128, 235, 1)),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: AlertDialogWidget(),
                          );
                        });
                  },
                  leading: Icon(Icons.circle,
                      size: 10, color: Theme.of(context).primaryColor),
                  title: Text(
                    "\$500,000 NGN - USD Dollars",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
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
                          "now",
                          style: TextStyle(
                              color: Color.fromRGBO(121, 128, 235, 1)),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: AlertDialogWidget(),
                          );
                        });
                  },
                  leading: Icon(
                    Icons.circle,
                    size: 10,
                    color: Color.fromRGBO(255, 72, 97, 1),
                  ),
                  title: Text(
                    "c1000 GHC - NGN Naira",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
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
                          "now",
                          style: TextStyle(
                              color: Color.fromRGBO(121, 128, 235, 1)),
                        )
                      ],
                    ),
                  ),
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

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Text(
            "Sell request summary",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.red[900],
              ),
              onPressed: () => Navigator.of(context).pop())
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text("To"),
              trailing: Text(
                "\N48,000",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text("Exchange rate"),
              trailing: Text(
                "\$1USD - N480 NGN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(121, 128, 235, 1)),
              ),
            ),
            ListTile(
              title: Text("Time frame"),
              trailing: Text(
                "24 Hrs",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(121, 128, 235, 1)),
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
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 13),
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
    );
  }
}
