import 'package:flutter/material.dart';

class BottomMenuBar extends StatefulWidget {
  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  bool _isMenuShow = false;
  @override
  Widget build(BuildContext context) {
    if (_isMenuShow) {
      return ClipPath(
        clipper: BottomMenuBarClipperPath(),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isMenuShow = false;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                color: Color.fromRGBO(62, 230, 192, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0), topRight: Radius.circular(5))),
            margin: EdgeInsets.only(top: 25),
            padding: EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 40,
                  height: 40,
                  child: FlatButton(
                      onPressed: () => {},
                      child: Text(
                        'Home',
                        style: TextStyle(
                            fontFamily: 'Mitr',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 25),
                      )),
                ),
                ButtonTheme(
                  minWidth: 40,
                  height: 40,
                  child: FlatButton(
                    onPressed: () => {},
                    child: Icon(Icons.search, color: Colors.white, size: 35),
                  ),
                ),
                ButtonTheme(
                  minWidth: 40,
                  height: 40,
                  child: FlatButton(
                    onPressed: () => {},
                    child: Icon(Icons.comment, color: Colors.white, size: 35),
                  ),
                ),
                ButtonTheme(
                  minWidth: 40,
                  height: 40,
                  child: FlatButton(
                    onPressed: () => {},
                    child:
                        Icon(Icons.data_usage, color: Colors.white, size: 35),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 230, 192, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(0),
          height: 10,
          child: RaisedButton(
            onPressed: () => {setState(() => _isMenuShow = true)},
            color: Color.fromRGBO(62, 230, 192, 1),
            elevation: 0.0,
          ),
        ),
      );
    }
  }
}

class BottomMenuBarClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(size.height, 25);
    var controllPoint = Offset(size.height + 100, 50);
    var endPoint = Offset(size.width / 1.6, size.height * 2);
    path.relativeQuadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(0, size.width + 100);
    path.lineTo(0, size.height + 200);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
