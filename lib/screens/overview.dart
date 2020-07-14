import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule_app/components/BottomMenuBar.dart';
import 'package:schedule_app/components/CalendarCarousel.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:schedule_app/model/DateProvider.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';
import 'package:schedule_app/services/CloudDataService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/components/EventLister.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
  final String uid;
  OverviewScreen({this.uid});
}

class _OverviewScreenState extends State<OverviewScreen> {
  final CloudDataService firestore = CloudDataService();
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return ChangeNotifierProvider<DateProvider>(
      create: (context) => DateProvider(),
      child: MaterialApp(
        locale: appLanguage.appLocal,
        supportedLocales: [
          Locale('en'),
          Locale('th'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Scaffold(
          body: SafeArea(
            child: SizedBox(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned(
                    top: 20,
                    right: 20,
                    child: TopOverlayBar(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 10),
                                child: Text(
                                  AppLocalizations.of(context).translate('hi'),
                                  style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('Users data')
                                        .document(widget.uid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        if (!snapshot.hasData) Text('User');
                                        var userData = snapshot.data;
                                        return Text(
                                          userData['name'],
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                112, 112, 112, 1),
                                          ),
                                        );
                                      } else {
                                        return Text('Not connect yet!');
                                      }
                                    }),
                              ),
                              Text(
                                '!',
                                style: TextStyle(
                                  fontFamily: 'Mitr',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('overview-welcome-message'),
                                  style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                CalendarCarousel(widget.uid),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              padding: EdgeInsets.only(bottom: 50),
                              child: EventLister(widget.uid),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: BottomMenuBar(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
