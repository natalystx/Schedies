import 'dart:io';

import 'package:flutter/material.dart';
import 'package:schedule_app/components/BottomMenuBar.dart';
import 'package:schedule_app/components/CalendarCarousel.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:schedule_app/model/DateProvider.dart';
import 'package:schedule_app/push_nofitications.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final CloudDataService firestore = CloudDataService();
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text("NO"),
                ),
                SizedBox(height: 16),
                new GestureDetector(
                  onTap: () => exit(0),
                  child: Text("YES"),
                ),
              ],
            ),
          ) ??
          false;
    }

    PushNotificationsManager().saveToken(widget.uid);
    var appLanguage = Provider.of<AppLanguage>(context);
    return ChangeNotifierProvider<DateProvider>(
      create: (context) => DateProvider(),
      child: Consumer<DateProvider>(
        builder: (context, provider, child) => Scaffold(
          body: WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeArea(
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
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 10),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('hi'),
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
                            StreamBuilder<QuerySnapshot>(
                                stream: firestore.firestore
                                    .collection('Events')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return Padding(padding: EdgeInsets.all(0));
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        StreamBuilder<DocumentSnapshot>(
                                            stream: firestore.firestore
                                                .collection('Users data')
                                                .document(widget.uid)
                                                .snapshots(),
                                            builder: (context, userSnapshot) {
                                              return CalendarCarousel(
                                                widget.uid,
                                                document: snapshot.data,
                                                name: userSnapshot.data['name'],
                                              );
                                            }),
                                      ],
                                    ),
                                  );
                                }),
                            SingleChildScrollView(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
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
      ),
    );
  }
}
