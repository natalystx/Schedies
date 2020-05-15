import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  String _text;
  double _fontSize;
  FontWeight _fontWeight;
  EdgeInsets paddingSide;

  WelcomeText(this._fontSize, this._fontWeight, this._text,
      {this.paddingSide = const EdgeInsets.only(top: 20)});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: paddingSide,
      child: Text(
        _text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Mitr',
            fontSize: _fontSize,
            fontWeight: _fontWeight,
            color: Color.fromRGBO(85, 85, 85, 1)),
      ),
    );
  }
}
