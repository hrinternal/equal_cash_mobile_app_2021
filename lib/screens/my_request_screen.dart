import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/component/form.dart';
import 'package:equal_cash/controllers/request.dart';
import 'package:equal_cash/models/api/offer.dart';
import 'package:equal_cash/models/api/request.dart';
import 'package:equal_cash/providers/transaction_provider.dart';
import 'package:equal_cash/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pref.dart';
import 'all_requests.dart';

class MyRequestScreen extends StatefulWidget {
  static const routeName = "request-screen";

  @override
  _MyRequestScreenState createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final requests = Provider.of<TransactionsProvider>(context);
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
            onPressed: () => Get.toNamed(HomeScreen.routeName),
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
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Created by you",
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
                flex: 5,
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
                height: 10,
              ),
              Expanded(
                flex: 30,
                child: FutureBuilder<String?>(
                    future: Settings.instance.userId,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading!");
                      } else {
                        if (!snapshot.hasData) {
                          return Text("Invalid user");
                        } else {
                          return GetBuilder<RequestController>(
                              init: RequestController(snapshot.data!),
                              builder: (controller) {
                                var requests = controller
                                        .requests.value.response?.data?.reversed
                                        .toList() ??
                                    [];
                                print(controller.requests.toJson());
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
                                                  text: 'You ',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 45)),
                                              TextSpan(
                                                  text: 'have no requests yet!',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))
                                            ]))
                                          ],
                                        ),
                                      ))
                                    ]),
                                  );
                                } else {
                                  requests.forEach((element) {
                                    print(element.toJson());
                                  });
                                  return ListView.builder(
                                      itemCount: requests.length,
                                      shrinkWrap: true,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        var request = requests[index];
                                        return Column(
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        child: AlertDialogWidget<
                                                            UserRequestDataBean>(
                                                          data: request,
                                                          options: "mine",
                                                        ),
                                                      );
                                                    });
                                              },
                                              leading: Icon(
                                                Icons.circle,
                                                size: 10,
                                              ),
                                              title: Text(
                                                "${request.amount} ${request.base_currency} - ${request.quote_currency}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Container(
                                                alignment: Alignment.centerLeft,
                                                // color: Colors.green,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Time frame - ${request.time_frame}hrs"),
                                                    // Spacer(),
                                                    SizedBox(
                                                      height: 1,
                                                    ),
                                                    RequestLabel(status: request.status??"0", numOffer: request.no_of_offer??0)
                                                  ],
                                                ),
                                              ),
                                              trailing: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    // Container(

                                                    //     color: Colors.amber,
                                                    //     child: Icon(Icons.more_vert)),
                                                    // Spacer(),
                                                    Text(
                                                      "${request.date_created}",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              121,
                                                              128,
                                                              235,
                                                              1)),
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
                              });
                        }
                      }
                    }),
              ),
              // SizedBox(height: 70),
              // Spacer(),
              // InkWell(
              //   onTap: () {},
              //   child: Text(
              //     "What do the colored dots mean?",
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Color.fromRGBO(121, 128, 235, 1)),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class RequestLabel extends StatelessWidget {
  const RequestLabel({
    Key? key, required this.status, required this.numOffer,
  }) : super(key: key);
final String status;
final num numOffer;
  @override
  Widget build(BuildContext context) {
    var noOffer = status=="0";
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      color: noOffer?Colors.grey:Color.fromARGB(255, 13, 183, 83),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          numOffer==0?"No offers yet":("$numOffer ${numOffer > 1?"offers":"offer"} "),
          style: TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AlertDialogWidget<T> extends StatelessWidget {
  const AlertDialogWidget({
    Key? key,
    this.data,
    this.options,
  }) : super(key: key);
  final T? data;
  final dynamic options;

  @override
  Widget build(BuildContext context) {
    UserRequestDataBean? myData;
    Map? allData;
    print(T);
    if (T == UserRequestDataBean) {
      myData = data as UserRequestDataBean?;
    } else {
      allData = data as Map?;
    }
    String amount = myData?.amount ?? allData?['amount'] ?? "";
    var bCurrency = myData?.base_currency ?? allData?['base_currency'] ?? "";
    var qCurrency = myData?.quote_currency ?? allData?['quote_currency'] ?? "";
    var timeFrame = myData?.time_frame ?? allData?['time_frame'] ?? "";
    var requestId = myData?.unique_id ?? allData?['unique_id'] ?? "";
    var userId = myData?.user_id ?? allData?['user_id'] ?? "";
    String rate = myData?.rate ?? allData?['rate'] ?? "";
    String status = myData?.status ?? allData?['status'] ?? "";
    num numOffer = myData?.no_of_offer ?? num.parse(allData?['no_of_offer']?? "0") ;
    return AlertDialog(
      contentPadding: EdgeInsets.all(5),
      title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: RequestLabel(status: status,numOffer: numOffer),
          trailing: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.cancel,
              color: Color.fromRGBO(121, 128, 235, 1),
              // color: Colors.red[900],
            ),
          )),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("From"),
              trailing: Text(
                // "\$100USD",
                "$amount $bCurrency",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text("To"),
              trailing: Text(
                // "\N48,000",
                "$amount $bCurrency",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text("Exchange rate"),
              trailing: Text(
                // "\$1USD - N480 NGN",
                // "${"$amount $bCurrency" "= ${"${num.parse(amount) * num.parse(rate)} $qCurrency"}"}",
                "${"1 $bCurrency" "= ${"$rate $qCurrency"}"}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(121, 128, 235, 1)),
              ),
            ),
            ListTile(
              title: Text("Time frame"),
              trailing: Text(
                "$timeFrame hrs",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(121, 128, 235, 1)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: double.maxFinite,
                // margin: EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    Get.back();
                    if (numOffer>0) {
                      _showMyRequestOptions(onClick: (option) {
                        Get.back();
                        switch (option) {
                          case MyRequestAction.edit:
                            _showEditDialog(requestId);
                            break;
                          case MyRequestAction.delete:
                            _showDeleteDialog(
                                amount, bCurrency, userId, requestId);
                            break;
                        }
                      });
                    } else {
                      showAllRequestOptions(onClick: (option) {
                        switch (option) {
                          case AllRequestAction.accept:
                            _showAcceptDialog(requestId, amount, bCurrency);
                            break;
                          case AllRequestAction.counter:
                            _showCounterDialog(requestId, amount, bCurrency);
                            break;
                        }
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Take action',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(requestId) {
    Get.dialog(AlertDialog(
        title: DialogHead(title: "Delete request"),
        content: Container(child: EditRequestWidget(requestId: requestId))));
  }

  void _showDeleteDialog(String amount, bCurrency, userId, requestId) {
    Get.dialog(AlertDialog(
        title: DialogHead(title: "Delete request"),
        content: Container(
          height: Get.height * 0.56,
          child: Column(
            children: [
              AlertMessageWidget(
                  alertMessage: "ARE YOU SURE YOU WANT TO DELETE THIS OFFER?"),
              SizedBox(
                height: 20,
              ),
              AlertPriceTile(
                  imagePath: "assets/images/usd.svg",
                  amount: amount,
                  currency: bCurrency),
              SizedBox(
                height: 15,
              ),
              SubmitButton(
                text: "Delete",
                bacColor: Colors.red,
                onClick: () {
                  ApiRepository()
                      .deleteRequest(userId, requestId)
                      .then((value) {
                    print(value.response!.message);
                    if (value.response!.status == 200) {
                      Get.back();
                      _showDeleteSuccess();
                    } else
                      Get.snackbar("", value.response!.message!);
                  });
                },
              )
            ],
          ),
        )));
  }

  void _showDeleteSuccess() {
    Get.dialog(AlertDialog(
      title: Center(
          child: Text(
        "Success",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      )),
      content: Container(
        height: Get.height * 0.3,
        child: Flex(
          direction: Axis.vertical,
          children: [
            SvgPicture.asset("assets/images/mark.svg",
                semanticsLabel: 'Acme Logo'),
            SizedBox(
              height: 25,
            ),
            AlertMessageWidget(
                alertMessage: "YOU HAVE SUCCESSFULLY DELETED THE REQUEST."),
            SizedBox(
              height: 40,
            ),
            SubmitButton(
              text: "Ok",
              onClick: () => Get.back(),
            )
          ],
        ),
      ),
    ));
  }

  void _showCounterDialog(requestId, String amount, bCurrency) {
    Get.dialog(AlertDialog(
      title: DialogHead(title: "Counter selling term"),
      content: Container(
        height: Get.height * 0.56,
        child: CounterFormWidget(
            requestId: requestId, amount: amount, currency: bCurrency),
      ),
    ));
  }

  void _showAcceptDialog(requestId, String amount, bCurrency) {
    Get.dialog(AlertDialog(
      title: DialogHead(title: "Buyer’s Account Details"),
      content: AcceptOfferWidget(
          requestId: requestId, amount: amount, currency: bCurrency),
      actionsOverflowDirection: VerticalDirection.down,
    ));
  }
}

class DialogHead extends StatelessWidget {
  const DialogHead({
    Key? key,
    required this.title,
    this.icon,
    this.iconColor,
    this.onTap,
  }) : super(key: key);
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      trailing: InkWell(
          onTap: () => onTap ?? Get.back(),
          child: Icon(icon ?? Icons.cancel_outlined,
              color: iconColor ?? Colors.redAccent)),
    );
  }
}

class EditRequestWidget extends StatefulWidget {
  EditRequestWidget({
    Key? key,
    required this.requestId,
  }) : super(key: key);

  final String requestId;

  @override
  _EditRequestWidgetState createState() => _EditRequestWidgetState();
}

class _EditRequestWidgetState extends State<EditRequestWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _bankNameController = TextEditingController();

  final _actNameController = TextEditingController();

  final _actNoController = TextEditingController();

  final _amountController = TextEditingController();

  final _rateController = TextEditingController();
  final _timeController = TextEditingController();

  String _fromCurrency = "NGN";

  String _toCurrency = "USD";

  @override
  Widget build(BuildContext context) {
    var currencyList = [
      DropdownMenuItem(
        value: "NGN",
        child: Text("NGN"),
      ),
      DropdownMenuItem(
        value: "USD",
        child: Text("USD"),
      ),
      DropdownMenuItem(
        value: "CYN",
        child: Text("CYN"),
      ),
    ];
    return Form(
      key: _formKey,
      child: ListView(
        // direction: Axis.vertical,
        children: [
          Text(
            "PLEASE MAKE SURE YOU ENTER CORRECT BANK ACCOUNT DETAILS",
            style: TextStyle(fontSize: 13, color: Colors.blueAccent),
          ),
          SizedBox(
            height: 20,
          ),
          LabeledForm(
              labelText: "RECIPIENT’S ACCOUNT NAME",
              textController: _actNameController),
          LabeledForm(
              keyboardType: TextInputType.number,
              labelText: "RECIPIENT’S ACCOUNT NUMBER",
              textController: _actNoController),
          LabeledForm(
              labelText: "RECIPIENT’S BANK NAME",
              textController: _bankNameController),
          LabeledForm(
              labelText: "AMOUNT",
              keyboardType: TextInputType.number,
              textController: _amountController),
          LabeledForm(
              labelText: "RATE",
              keyboardType: TextInputType.number,
              textController: _rateController),
          LabeledForm(
              labelText: "TIME FRAME",
              keyboardType: TextInputType.number,
              textController: _timeController),
          LabeledDropDownForm(
            labelText: "FROM",
            items: currencyList,
            value: _fromCurrency,
            onChanged: (String? value) {
              _fromCurrency = value ?? "";
            },
          ),
          LabeledDropDownForm(
            labelText: "TO",
            items: currencyList,
            value: _toCurrency,
            onChanged: (String? value) {
              setState(() {
                _toCurrency = value ?? "";
              });
            },
          ),
          SubmitButton(
              text: "Edit",
              onClick: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                //call accept offer endpoint
                print(widget.requestId);
                ApiRepository()
                    .editRequest(EditRequestParam(
                  unique_id: widget.requestId,
                  bank_name: _bankNameController.text,
                  account_number: _actNoController.text,
                  account_name: _actNameController.text,
                  base_currency: _fromCurrency,
                  quote_currency: _toCurrency,
                  time_frame: _timeController.text,
                  rate: _rateController.text,
                  amount: _amountController.text,
                ))
                    .then((value) {
                  print(value.response!.message);
                  if (value.response!.status == 200) {
                    Get.back();
                    _showEditSuccess();
                  } else
                    Get.snackbar("", value.response!.message!);
                });
              }),
        ],
      ),
    );
  }

  void _showEditSuccess() {
    Get.dialog(AlertDialog(
      title: Center(
          child: Text(
        "Success",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      )),
      content: Container(
        height: Get.height * 0.32,
        child: Flex(
          direction: Axis.vertical,
          children: [
            SvgPicture.asset("assets/images/mark.svg",
                semanticsLabel: 'Acme Logo'),
            SizedBox(
              height: 25,
            ),
            AlertMessageWidget(
                alertMessage: "YOU HAVE SUCCESSFULLY EDITTED THE REQUEST."),
            SizedBox(
              height: 40,
            ),
            SubmitButton(
              text: "Ok",
              onClick: () => Get.back(),
            )
          ],
        ),
      ),
    ));
  }
}

class AcceptOfferWidget extends StatelessWidget {
  AcceptOfferWidget({
    Key? key,
    required this.requestId,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  final String requestId;
  final String amount;
  final String currency;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _bankNameController = TextEditingController();
  final _actNameController = TextEditingController();
  final _actNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        // direction: Axis.vertical,
        children: [
          Text(
              "Note: money sent to a wrong bank by mistake will be difficult or impossible to retrieve and you take full responsibility.",
              style: TextStyle(
                fontSize: 13,
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "PLEASE MAKE SURE YOU ENTER CORRECT BANK ACCOUNT DETAILS",
            style: TextStyle(
                fontSize: 13,
                // fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          SizedBox(
            height: 20,
          ),
          LabeledForm(
              labelText: "RECIPIENT’S ACCOUNT NAME",
              textController: _actNameController),
          LabeledForm(
              keyboardType: TextInputType.number,
              labelText: "RECIPIENT’S ACCOUNT NUMBER",
              textController: _actNoController),
          LabeledForm(
              labelText: "RECIPIENT’S BANK NAME",
              textController: _bankNameController),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 22),
            child: SubmitButton(onClick: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              //call accept offer endpoint
              var userId = await Settings.instance.userId;
              print(userId);
              print(requestId);
              ApiRepository()
                  .acceptOfferSeller(AcceptOfferParam(
                      requestId: requestId,
                      userId: userId,
                      bankName: _bankNameController.text,
                      accountNumber: _actNoController.text,
                      accountName: _actNameController.text,
                      transactionId: ""))
                  .then((value) {
                Get.back();
                _showAcceptSuccessDialog();
                print(value.response!.message);
              });
            }),
          ),
        ],
      ),
    );
  }

  void _showAcceptSuccessDialog() {
    Get.dialog(AlertDialog(
      title: Center(
        child: Text(
          "You accepted an offer",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        height: Get.height * 0.34,
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            SvgPicture.asset("assets/images/mark.svg",
                semanticsLabel: 'Acme Logo'),
            SizedBox(
              height: 15,
            ),
            AlertMessageWidget(
                alertMessage:
                    "YOU HAVE JUST ACCEPTED AN OFFER. TRANSFER TO 2076354427 (FIDELITY BANK)"),
            SizedBox(
              height: 20,
            ),
            AlertPriceTile(
                imagePath: "assets/images/usd.svg",
                amount: amount,
                currency: currency),
            SizedBox(
              height: 15,
            ),
            SubmitButton(
              text: "Ok",
              onClick: () => Get.back(),
            )
          ],
        ),
      ),
    ));
  }
}

class AlertPriceTile extends StatelessWidget {
  const AlertPriceTile({
    Key? key,
    required this.imagePath,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  final String imagePath;
  final String amount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, semanticsLabel: 'Acme Logo'),
          SizedBox(
            width: 10,
          ),
          Text(
            "$amount $currency",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ]);
  }
}

class CounterFormWidget extends StatefulWidget {
  CounterFormWidget({
    Key? key,
    required this.requestId,
    required this.amount,
    required this.currency,
  }) : super(key: key);

  final String requestId;
  final String amount;
  final String currency;

  @override
  _CounterFormWidgetState createState() => _CounterFormWidgetState();
}

class _CounterFormWidgetState extends State<CounterFormWidget> {
  String _dropdownValue = '50%';

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _timeController = TextEditingController();

  final _rateController = TextEditingController();

  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          LabeledForm(
              keyboardType: TextInputType.number,
              labelText: "COUNTER TIME (IN HOURS)",
              textController: _timeController),
          LabeledForm(
              keyboardType: TextInputType.number,
              labelText: "COUNTER RATE",
              textController: _rateController),
          LabeledDropDownForm(
              labelText: "COUNTER AMOUNT",
              value: _dropdownValue,
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value ?? "";
                });
              },
              items: [
                DropdownMenuItem(
                    value: "50%", child: Text("50% of initial amount")),
                DropdownMenuItem(
                  value: "75%",
                  child: Text("75% of initial amount"),
                ),
                DropdownMenuItem(
                    value: "100%", child: Text("100% of initial amount"))
              ]),
          SubmitButton(onClick: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            //call accept offer endpoint
            var userId = await Settings.instance.userId;
            print(userId);
            print(widget.requestId);
            ApiRepository()
                .counterOfferBuyer(CounterBuyerOffer(
              request_id: widget.requestId,
              user_id: userId,
              counter_time: _timeController.text,
              counter_amount: _dropdownValue,
              counter_rate: _rateController.text,
            ))
                .then((value) {
              print(value.toJson());
              Get.back();
              var response = value.response;
              if (response!.status == 200) {
                _showCounterSuccess();
              } else {
                Get.snackbar("", response.message!);
              }
              print(response.message);
            });
          }),
        ],
      ),
    );
  }

  void _showCounterSuccess() {
    Get.dialog(AlertDialog(
      title: Center(
          child: Text(
        "Success",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      )),
      content: Container(
        height: Get.height * 0.25,
        child: Flex(
          direction: Axis.vertical,
          children: [
            SvgPicture.asset("assets/images/mark.svg",
                semanticsLabel: 'Acme Logo'),
            SizedBox(
              height: 25,
            ),
            AlertMessageWidget(
                alertMessage: "YOUR COUNTER OFFER HAS BEEN SENT."),
            SizedBox(
              height: 40,
            ),
            SubmitButton(
              text: "Ok",
              onClick: () => Get.back(),
            )
          ],
        ),
      ),
    ));
  }
}

class AlertMessageWidget extends StatelessWidget {
  const AlertMessageWidget({
    Key? key,
    required this.alertMessage,
  }) : super(key: key);

  final String alertMessage;

  @override
  Widget build(BuildContext context) {
    return Text(
      alertMessage,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    );
  }
}

enum MyRequestAction { edit, delete }

Future<void> _showMyRequestOptions(
    {required Null Function(MyRequestAction option) onClick}) async {
  switch (await showDialog<MyRequestAction>(
      context: Get.context!,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select an Action'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, MyRequestAction.edit);
              },
              child: const Text('Edit'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, MyRequestAction.delete);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      })) {
    case MyRequestAction.edit:
      onClick(MyRequestAction.edit);
      break;
    case MyRequestAction.delete:
      onClick(MyRequestAction.delete);
      break;
    case null:
      // dialog dismissed
      break;
  }
}
