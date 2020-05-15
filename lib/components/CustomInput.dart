import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  Color _inputFillColor;
  IconData _prefixIcon;
  String _placeholder;
  bool _secure;
  TextInputType _inputType;
  CustomInput(this._inputFillColor, this._placeholder, this._prefixIcon,
      this._secure, this._inputType);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _secure,
      decoration: new InputDecoration(
        prefixIcon: Icon(
          _prefixIcon,
          color: Colors.white,
          size: 24.0,
        ),
        labelText: _placeholder,
        labelStyle: new TextStyle(
            fontFamily: "Mitr",
            fontSize: 15,
            fontWeight: FontWeight.w200,
            color: Colors.white),
        fillColor: _inputFillColor,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white)),
        filled: true,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
          borderSide: new BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: _inputType,
      style: new TextStyle(
          fontFamily: "Mitr",
          fontSize: 18,
          fontWeight: FontWeight.w200,
          color: Colors.white),
    );
  }
}
