import 'package:flutter/material.dart';
import '../components/CustomButton.dart';
import '../components/CustomInput.dart';
import '../components/WelcomeText.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 80),
                      child:
                          Image(image: AssetImage('assets/images/2785427.png')),
                    )
                  ],
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 55,
                      width: 350,
                      margin: EdgeInsets.only(bottom: 20),
                      child: CustomInput(
                          Color.fromRGBO(250, 137, 123, 1),
                          'Email',
                          Icons.alternate_email,
                          false,
                          TextInputType.emailAddress),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 55,
                      width: 350,
                      margin: EdgeInsets.only(bottom: 40),
                      child: CustomInput(Color.fromRGBO(62, 230, 192, 1),
                          'Password', Icons.dialpad, true, TextInputType.text),
                    )
                  ],
                ),
                CustomButton(
                    Color.fromRGBO(255, 221, 148, 1),
                    'Sign in',
                    20,
                    AssetImage('assets/images/account.png'),
                    MaterialPageRoute(builder: (context) => null)),
                CustomButton(
                    Color.fromRGBO(85, 85, 85, 1),
                    'Forgot password?',
                    20,
                    AssetImage('assets/images/passkey.png'),
                    MaterialPageRoute(builder: (context) => null))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
