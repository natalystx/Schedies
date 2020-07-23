import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/TopOverlayBar.dart';
import '../components/WelcomeText.dart';
import '../services/AppLanguage.dart';
import '../services/AppLocalizations.dart';
import '../wrapper.dart';

class ForgotPassScreen extends StatefulWidget {
  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  String _email;
  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      if (_email.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("We're already send email for password reset."),
              content: new Text("Please check in your email inbox."),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Okay"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Wrapper()));
                  },
                ),
              ],
            );
          },
        );
      }
    }

    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            top: 20,
            right: MediaQuery.of(context).size.width - 80,
            child: TopOverlayBar(
              isShowBackButton: true,
              isShowRightIcon: false,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 150),
                    child: Image(
                      image: AssetImage('assets/images/3275434.png'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      WelcomeText(15, FontWeight.w300,
                          AppLocalizations.of(context).translate('are-you'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      WelcomeText(
                        35,
                        FontWeight.w400,
                        AppLocalizations.of(context)
                            .translate('forgot-password'),
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
                        AppLocalizations.of(context).translate('let-us-help'),
                        paddingSide: EdgeInsets.only(bottom: 40),
                      )
                    ],
                  ),
                  Container(
                    height: 55,
                    width: 350,
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      onChanged: (value) => {setState(() => _email = value)},
                      obscureText: false,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        labelText:
                            AppLocalizations.of(context).translate('email'),
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
                            elevation: 0,
                            onPressed: () async => {
                              if (_email.isNotEmpty)
                                {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(email: _email),
                                  _showDialog()
                                }
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
                                  AppLocalizations.of(context)
                                      .translate('forgot-pass'),
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
          )
        ],
      )),
    );
  }
}
