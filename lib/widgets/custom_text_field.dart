import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController? controller = TextEditingController();
  String? hintName;

  CustomTextField({this.controller, this.hintName});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hintName,
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
    );
  }
}
