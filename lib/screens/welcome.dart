import 'package:flutter/material.dart';
import 'package:schedule_app/components/WelcomeText.dart';
import 'package:schedule_app/components/CustomButton.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Locale myLocale = Locale('en');

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    myLocale = appLanguage.appLocal;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          // flag icon
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (myLocale.languageCode == 'en') {
                                      myLocale = Locale('th');
                                      appLanguage.changeLanguage(myLocale);
                                    } else {
                                      myLocale = Locale('en');
                                      appLanguage.changeLanguage(myLocale);
                                    }
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 0, right: 30),
                                  width: 26,
                                  height: 26,
                                  child: Image(
                                    image: myLocale.languageCode == 'en'
                                        ? AssetImage(
                                            'assets/images/country.png')
                                        : AssetImage(
                                            'assets/images/nation.png',
                                          ),
                                  ),
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
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/2473674.png')),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(210.0)),
                                  color: Color.fromARGB(255, 32, 32, 32),
                                ),
                              ),
                            ],
                          ),
                          //texts section
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
                                AppLocalizations.of(context)
                                    .translate('welcome-message'),
                                paddingSide: EdgeInsets.only(bottom: 80),
                              )
                            ],
                          ),
                          //buttons section
                          CustomButton(
                              Color.fromRGBO(250, 137, 123, 1),
                              AppLocalizations.of(context)
                                  .translate('have-exist-account'),
                              19,
                              AssetImage('assets/images/account.png'),
                              '/signin'),
                          // CustomButton(
                          //     Color.fromRGBO(62, 230, 192, 1),
                          //     'Sign in with Google account.',
                          //     19,
                          //     AssetImage('assets/images/Group170.png'),
                          //     MaterialPageRoute(builder: (context) => null)),
                          CustomButton(
                              Color.fromRGBO(255, 211, 138, 1),
                              AppLocalizations.of(context)
                                  .translate('dont-have-any-account'),
                              14,
                              AssetImage('assets/images/arrows.png'),
                              '/signup'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
