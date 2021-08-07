import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PasswordInputForm extends StatefulWidget {
  const PasswordInputForm({Key? key, required this.passwordController})
      : super(key: key);
  final TextEditingController passwordController;

  @override
  _PasswordInputFormState createState() => _PasswordInputFormState();
}

class _PasswordInputFormState extends State<PasswordInputForm> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: widget.passwordController,
      onSaved: (password) {
        // passwords["oldPassword"] = password;
      },
      validator: (password) {
        //  if(isLength())
        if (password!.isEmpty) {
          return "Please enter your password";
        } else {
          return null;
        }
      },
      obscureText: isVisible,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Old Password",
          labelStyle: TextStyle(fontSize: 18),
          suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              })),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm(
      {Key? key,
      required this.textController,
      this.keyboardType,
      this.hintText,
      this.errorText})
      : super(key: key);
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: textController,
      // onSaved: (text) {
      // passwords["oldPassword"] = password;
      // },
      validator: (text) {
        if (text!.isEmpty) {
          return errorText ?? "You can't leave this box empty!";
        } else {
          return null;
        }
      },
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        errorText: errorText,
        labelText: hintText ?? "Enter Text",
        labelStyle: TextStyle(fontSize: 18),
      ),
    );
  }
}

class FormDropDown extends StatelessWidget {
  const FormDropDown(
      {Key? key,
      required this.items,
      required this.onChanged,
      required this.value})
      : super(key: key);
  final List<DropdownMenuItem<String>> items;
  final Function(String? value) onChanged;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField<String>(
        items: items,
        value: value,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

class LabeledDropDownForm extends StatelessWidget {
  const LabeledDropDownForm(
      {Key? key,
      this.labelText,
      required this.items,
      required this.onChanged,
      required this.value})
      : super(key: key);
  final String? labelText;
  final List<DropdownMenuItem<String>> items;
  final Function(String? value) onChanged;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText ?? ""),
        if (labelText != null) SizedBox(height: 10),
        FormDropDown(
          items: items,
          value: value,
          onChanged: onChanged,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class LabeledForm extends StatelessWidget {
  const LabeledForm(
      {Key? key,
      required this.textController,
      this.keyboardType,
      this.hintText,
      this.errorText,
      this.labelText})
      : super(key: key);

  final TextEditingController textController;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? errorText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText ?? ""),
        if (labelText != null) SizedBox(height: 10),
        InputForm(
          textController: textController,
          keyboardType: keyboardType,
          hintText: hintText,
          errorText: errorText,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    this.onClick,
    this.text, this.bacColor,
  }) : super(key: key);

  final Function()? onClick;
  final String? text;
  final Color? bacColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
      child: Container(
          width: double.maxFinite,
          child: TextButton(
        style: TextButton.styleFrom(elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(vertical: 12,),
          backgroundColor: bacColor??Theme.of(context).primaryColor,
        ),
        onPressed: onClick,
        child: Text(
          text ?? "Send",
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }
}
