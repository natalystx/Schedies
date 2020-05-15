import 'package:flutter/material.dart';
import '../components/WelcomeText.dart';
import '../components/CustomInput.dart';
import '../components/CustomButton.dart';
import '../screens/signIn.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child:
                        Image(image: AssetImage('assets/images/3235815.png')),
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
                        Color.fromRGBO(62, 230, 192, 1),
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
                    margin: EdgeInsets.only(bottom: 20),
                    child: CustomInput(Color.fromRGBO(62, 230, 192, 1),
                        'Password', Icons.dialpad, true, TextInputType.text),
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
                        Color.fromRGBO(62, 230, 192, 1),
                        'Confirm Password',
                        Icons.dialpad,
                        true,
                        TextInputType.text),
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
                    child: CustomInput(Color.fromRGBO(62, 230, 192, 1), 'Name',
                        Icons.account_circle, false, TextInputType.text),
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
                    child: CustomInput(Color.fromRGBO(62, 230, 192, 1),
                        'Phonenumber', Icons.call, false, TextInputType.phone),
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
                        Color.fromRGBO(62, 230, 192, 1),
                        'User status',
                        Icons.more_vert,
                        false,
                        TextInputType.text),
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
                        Color.fromRGBO(62, 230, 192, 1),
                        'Student ID',
                        Icons.school,
                        false,
                        TextInputType.number),
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
                    child: CustomInput(Color.fromRGBO(62, 230, 192, 1),
                        'Profile image', Icons.image, false, TextInputType.url),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 50),
                child: CustomButton(
                    Color.fromRGBO(255, 221, 148, 1),
                    'Sign up',
                    20,
                    AssetImage('assets/images/account.png'),
                    MaterialPageRoute(builder: (context) => SignInScreen())),
              )
            ],
          ),
        ),
      )),
    );
  }
}
