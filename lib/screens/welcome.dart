import 'package:flutter/material.dart';
import 'package:schedule_app/components/WelcomeText.dart';
import 'package:schedule_app/components/CustomButton.dart';
import 'package:schedule_app/screens/signIn.dart';
import 'package:schedule_app/screens/signUp.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // flag icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0, right: 30),
                      width: 26,
                      height: 26,
                      child: Image(
                        image: AssetImage('assets/images/country.png'),
                      ),
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
                      child:
                          Image(image: AssetImage('assets/images/2473674.png')),
                      decoration: new BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(Radius.circular(210.0)),
                        color: Color.fromARGB(255, 32, 32, 32),
                      ),
                    ),
                  ],
                ),
                //texts section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    WelcomeText(15, FontWeight.w300, 'Welcome to')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    WelcomeText(
                      35,
                      FontWeight.w400,
                      'Schedie',
                      paddingSide: EdgeInsets.only(top: 0),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    WelcomeText(
                      15,
                      FontWeight.w300,
                      'The tools for manage your plans.',
                      paddingSide: EdgeInsets.only(bottom: 40),
                    )
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
                    Color.fromRGBO(255, 211, 138, 1),
                    'Don’t have any Schedie’s account?',
                    14,
                    AssetImage('assets/images/arrows.png'),
                    MaterialPageRoute(builder: (context) => SignUpScreen())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
