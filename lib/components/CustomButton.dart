import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String _buttonTitle;
  Color _buttonColor;
  double _fontSize;
  AssetImage _imageIcon;
  MaterialPageRoute _route;
  CustomButton(this._buttonColor, this._buttonTitle, this._fontSize,
      this._imageIcon, this._route);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: ButtonTheme(
            minWidth: 350,
            height: 50,
            child: RaisedButton(
              onPressed: () => {Navigator.push(context, _route)},
              color: _buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 24,
                    height: 24,
                    margin: EdgeInsets.only(right: 10),
                    child: Image(
                      image: _imageIcon,
                    ),
                  ),
                  Text(
                    _buttonTitle,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Mitr',
                        fontSize: _fontSize,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
