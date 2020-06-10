import 'package:flutter/material.dart';
import 'package:schedule_app/components/BottomMenuBar.dart';
import 'package:schedule_app/components/CalendarCarousel.dart';
import 'package:schedule_app/components/EventLister.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/model/User.dart';
import 'package:schedule_app/services/AuthService.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  final String documentID;
  bool isMe;
  MyProfileScreen(this.documentID, {this.isMe = false});
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    widget.isMe = user.uid == widget.documentID ? true : widget.isMe;
    return MaterialApp(
      home: Scaffold(
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
                                  Text(
                                    snapshot.data['name'],
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(85, 85, 85, 1),
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
                                                          Radius.circular(20))),
                                              elevation: 0,
                                              color: Color.fromRGBO(
                                                  250, 137, 123, 1),
                                              onPressed: () {},
                                              child: Text(
                                                'Edit',
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
                                                onPressed: () {
                                                  AuthServices().signOut();
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
                                                onPressed: () {},
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
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'User status: ' +
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
                                    'Email: ' + snapshot.data['email'],
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
                                    'Phone: ' + snapshot.data['phoneNumber'],
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
                                          'StudentID: ' +
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
                                      EdgeInsets.only(left: 20, bottom: 50),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
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
      ),
    );
  }
}
