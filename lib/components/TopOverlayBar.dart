import 'package:flutter/material.dart';
import 'package:schedule_app/model/User.dart';
import 'package:schedule_app/screens/myProfile.dart';
import 'package:schedule_app/wrapper.dart';
import 'package:provider/provider.dart';

class TopOverlayBar extends StatelessWidget {
  bool isShowBackButton;
  String uid;
  TopOverlayBar({this.isShowBackButton = false, this.uid});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(right: 0, top: 0),
          child: isShowBackButton
              ? ButtonTheme(
                  minWidth: 50,
                  height: 25,
                  buttonColor: Color.fromRGBO(250, 137, 123, 1),
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new Wrapper(),
                        ),
                      )
                    },
                    elevation: 0,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 12,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontFamily: 'Mitr',
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : null,
        ),
        Container(
          margin: EdgeInsets.only(right: 0, left: 220, top: 0),
          child: ButtonTheme(
            minWidth: 20,
            height: 20,
            padding: EdgeInsets.all(0),
            child: FlatButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Wrapper(),
                  ),
                )
              },
              child: Image(
                image: AssetImage('assets/images/interface.png'),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 0, top: 0),
          child: ButtonTheme(
            minWidth: 20,
            height: 20,
            padding: EdgeInsets.all(0),
            child: FlatButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyProfileScreen(
                            user.uid,
                            isMe: true,
                          )),
                )
              },
              child: Image(
                image: AssetImage('assets/images/social-media.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
