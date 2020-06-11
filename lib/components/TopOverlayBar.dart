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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
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
            margin: EdgeInsets.only(
                right: 0, left: MediaQuery.of(context).size.width / 2, top: 0),
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
                child: Icon(
                  Icons.calendar_today,
                  size: 23,
                  color: Color.fromRGBO(85, 85, 85, .7),
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
                child: Icon(
                  Icons.account_circle,
                  size: 28,
                  color: Color.fromRGBO(85, 85, 85, .7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
