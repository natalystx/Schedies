import 'package:flutter/material.dart';
import 'package:schedule_app/components/WelcomeText.dart';

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
                      child: TextFormField(
                        onChanged: (value) => {},
                        obscureText: false,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          labelText: 'Email',
                          labelStyle: new TextStyle(
                              fontFamily: "Mitr",
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                          fillColor: Color.fromRGBO(250, 137, 123, 1),
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
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                            fontFamily: "Mitr",
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
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
                        child: TextFormField(
                          onChanged: (value) => {},
                          obscureText: true,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.dialpad,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: 'Password',
                            labelStyle: new TextStyle(
                                fontFamily: "Mitr",
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: Colors.white),
                            fillColor: Color.fromRGBO(62, 230, 192, 1),
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
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                              fontFamily: "Mitr",
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ButtonTheme(
                        minWidth: 350,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => null))
                          },
                          color: Color.fromRGBO(255, 221, 148, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 24,
                                height: 24,
                                margin: EdgeInsets.only(right: 10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/account.png'),
                                ),
                              ),
                              Text(
                                'Sign in',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ButtonTheme(
                        minWidth: 350,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => null))
                          },
                          color: Color.fromRGBO(85, 85, 85, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 24,
                                height: 24,
                                margin: EdgeInsets.only(right: 10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/passkey.png'),
                                ),
                              ),
                              Text(
                                'Forgot password?',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
