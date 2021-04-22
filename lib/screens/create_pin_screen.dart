import 'package:equal_cash/screens/confirm_pin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class CreatePinScreen extends StatefulWidget {
  static const String routeName = "create-pin";
  @override
  _CreatePinScreenState createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final _formKey = GlobalKey();
  final _pinController = TextEditingController();

  var onTapRecognizer;
  bool shiftEnabled;

  @override
  void initState() {
    super.initState();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    // errorController = StreamController<ErrorAnimationType>();

    shiftEnabled = false;
    text = '';
  }

  String text;
  VirtualKeyboardKeyType keyType;

  VirtualKeyboardKeyAction action;

  bool isComplete = false;

  /// Fired when the virtual keyboard key is pressed.
  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      text += key.text;
      if (text.length == 4) {
        setState(() {
          isComplete = true;
        });
      }
      if (text.length == 5) {
        return text = '';
      }
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          text = text + '\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          text = text + key.text;
          break;
        case VirtualKeyboardKeyAction.Shift:
          shiftEnabled = !shiftEnabled;
          break;
        default:
      }
    }
// Update the screen
    setState(() {
      print(text);
      _pinController.text = text;
    });
  }

  Widget _builder(BuildContext context, VirtualKeyboardKey key) {
    Widget keyWidget;

    switch (key.keyType) {
      case VirtualKeyboardKeyType.String:
        keyWidget = _onKeyPress(key);
        break;
      case VirtualKeyboardKeyType.Action:
        keyWidget = _onKeyPress(key);
        break;
    }

    setState(() {
      print(key.text);
    });

    return keyWidget;
  }

  // @override
  // void dispose() {
  //   _pinController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    if (isComplete) {
      Future.delayed(Duration(seconds: 1),
          () => Navigator.of(context).pushNamed(ConfirmPinScreen.routeName));
      setState(() {
        isComplete = false;
        // _pinController.clear();
        text = "";
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(121, 128, 235, 1)),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Create a PIN",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Use PIN to securely log into the app",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              height: 50,
              child: Form(
                key: _formKey,
                child: PinCodeTextField(
                  enabled: false,
                  onCompleted: (value) {
                    if (value.length == 4) {
                      Navigator.of(context)
                          .pushNamed(ConfirmPinScreen.routeName);
                    }
                  },
                  onChanged: (changedValue) {
                    print(_pinController.text.length);
                    if (isComplete) {
                      Navigator.of(context)
                          .pushNamed(ConfirmPinScreen.routeName);
                    }
                  },
                  appContext: context,
                  length: 4,
                  animationDuration: Duration(milliseconds: 500),
                  animationType: AnimationType.scale,
                  controller: _pinController,
                  pinTheme: PinTheme.defaults(
                      borderWidth: 2,
                      activeColor: Colors.red[900],
                      inactiveColor: Color.fromRGBO(
                        14,
                        129,
                        59,
                        1,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              child: VirtualKeyboard(
                type: VirtualKeyboardType.Numeric,
                onKeyPress: _onKeyPress,
                builder: _builder,
                height: MediaQuery.of(context).size.height * 0.35,
                textColor: Colors.black,
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
