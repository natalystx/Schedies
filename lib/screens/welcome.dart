import 'package:flutter/material.dart';
import '../components/CustomButton.dart';
import '../screens/signIn.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          children: <Widget>[
            // flag icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 75, right: 20),
                  width: 26,
                  height: 26,
                  child: Image(
                    image: AssetImage('assets/images/country.png'),
                  ),
                  alignment: Alignment.topRight,
                ),
              ],
            ),
            //pic icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 210,
                  height: 210,
                  margin: EdgeInsets.only(top: 100),
                  alignment: Alignment.center,
                  child: Image(image: AssetImage('assets/images/2473674.png')),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(210.0)),
                    color: Color.fromARGB(255, 32, 32, 32),
                  ),
                ),
              ],
            ),
            //texts section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Welcome to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Mitr',
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(85, 85, 85, 1)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    'Schedie',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Mitr',
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(85, 85, 85, 1)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 55),
                  child: Text(
                    'The tools for manage your plans.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Mitr',
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(85, 85, 85, 1)),
                  ),
                ),
              ],
            ),
            //buttons section
            CustomButton(
                Color.fromRGBO(250, 137, 123, 1),
                'Sign in with exist account.',
                19,
                AssetImage('assets/images/account.png'),
                MaterialPageRoute(builder: (context) => SignInScreen())),
            CustomButton(
                Color.fromRGBO(62, 230, 192, 1),
                'Sign in with Google account.',
                19,
                AssetImage('assets/images/Group170.png'),
                MaterialPageRoute(builder: (context) => null)),
            CustomButton(
                Color.fromRGBO(255, 221, 148, 1),
                'Don’t have any Schedie’s account?',
                14,
                AssetImage('assets/images/arrows.png'),
                MaterialPageRoute(builder: (context) => null)),
          ],
        ),
      )),
    );
  }
}
