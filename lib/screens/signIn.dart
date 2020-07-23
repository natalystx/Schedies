import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule_app/components/WelcomeText.dart';
import 'package:schedule_app/screens/forgotPass.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';
import 'package:schedule_app/services/AuthService.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email;
  String _password;
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                    WelcomeText(
                        15,
                        FontWeight.w300,
                        AppLocalizations.of(context)
                            .translate('welcome-header'))
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
                      AppLocalizations.of(context).translate('welcome-message'),
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
                          onChanged: (value) =>
                              {setState(() => _password = value)},
                          obscureText: true,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.dialpad,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: AppLocalizations.of(context)
                                .translate('password'),
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
                          elevation: 0,
                          onPressed: () async => {
                            await _auth.signInWithEmailAndPassword(
                                _email, _password),
                            Navigator.popAndPushNamed(context, '/wrapper')
                          },
                          color: Color.fromRGBO(255, 211, 138, 1),
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
                                AppLocalizations.of(context)
                                    .translate('sign-in'),
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
                          elevation: 0,
                          onPressed: () =>
                              {Navigator.pushNamed(context, '/forgotpass')},
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
        ),
      ),
    );
  }
}
