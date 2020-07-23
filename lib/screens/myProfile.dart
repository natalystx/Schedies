import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule_app/components/BottomMenuBar.dart';
import 'package:schedule_app/components/CalendarCarousel.dart';
import 'package:schedule_app/components/EventLister.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/model/DateProvider.dart';
import 'package:schedule_app/model/User.dart';
import 'package:schedule_app/screens/chatting.dart';
import 'package:schedule_app/screens/updateData.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';
import 'package:schedule_app/services/AuthService.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  final String documentID;
  bool isMe;
  MyProfileScreen({this.documentID, this.isMe = false});
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String chatID;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    widget.isMe = user.uid == widget.documentID ? true : widget.isMe;
    return ChangeNotifierProvider<DateProvider>(
        create: (context) => DateProvider(),
        child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  StreamBuilder<DocumentSnapshot>(
                      stream: Firestore.instance
                          .collection('Users data')
                          .document(widget.documentID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Text('No data');
                        return SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 500,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(350),
                                  ),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        snapshot.data['imageProfile']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 20, bottom: 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.8,
                                      child: Text(
                                        snapshot.data['name'],
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(85, 85, 85, 1),
                                        ),
                                      ),
                                    ),
                                    widget.isMe
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 10),
                                            child: ButtonTheme(
                                              minWidth: 55,
                                              height: 25,
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                elevation: 0,
                                                color: Color.fromRGBO(
                                                    250, 137, 123, 1),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateDataScreen(
                                                              document: snapshot
                                                                  .data),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate('edit'),
                                                  style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Text(''),
                                    widget.isMe
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, right: 10),
                                            child: ButtonTheme(
                                              minWidth: 25,
                                              height: 25,
                                              child: FlatButton(
                                                  onPressed: () async {
                                                    await AuthServices()
                                                        .signOut();
                                                    Navigator.popAndPushNamed(
                                                        context, '/wrapper');
                                                  },
                                                  child: Icon(
                                                    Icons.power_settings_new,
                                                    size: 25,
                                                    color: Color.fromRGBO(
                                                        85, 85, 85, .8),
                                                  )),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, right: 10),
                                            child: ButtonTheme(
                                              minWidth: 25,
                                              height: 25,
                                              child: FlatButton(
                                                  onPressed: () {
                                                    if (user.uid.hashCode <=
                                                        widget.documentID
                                                            .hashCode) {
                                                      chatID =
                                                          '${user.uid}-${widget.documentID}';
                                                    } else {
                                                      chatID =
                                                          '${widget.documentID}-${user.uid}';
                                                    }
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChattingScreen(
                                                                chatID: chatID,
                                                                isShowChat:
                                                                    true,
                                                                receiver:
                                                                    snapshot
                                                                        .data,
                                                              )),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.forum,
                                                    size: 25,
                                                    color: Color.fromRGBO(
                                                        85, 85, 85, .8),
                                                  )),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                              .translate('user-status-2') +
                                          snapshot.data['userStatus'],
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                              .translate('email-2') +
                                          snapshot.data['email'],
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                              .translate('phone') +
                                          snapshot.data['phoneNumber'],
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    snapshot.data['studentID'] != null
                                        ? Text(
                                            AppLocalizations.of(context)
                                                    .translate('student-id-2') +
                                                snapshot.data['studentID'],
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  Color.fromRGBO(85, 85, 85, 1),
                                            ),
                                          )
                                        : Text(''),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20, top: 30),
                                    child: CalendarCarousel(
                                      widget.documentID,
                                      isMe: widget.isMe,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, bottom: 20),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      padding: EdgeInsets.only(bottom: 50),
                                      child: EventLister(widget.documentID),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: TopOverlayBar(
                      isShowBackButton: true,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: BottomMenuBar(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
