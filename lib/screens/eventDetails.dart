import 'package:flutter/material.dart';
import 'package:schedule_app/components/BottomMenuBar.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/wrapper.dart';

class EventDetailsScreen extends StatefulWidget {
  final DocumentSnapshot _document;
  final String _uid;
  EventDetailsScreen(this._document, this._uid);
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //Incase user is receiver
    if (widget._uid == widget._document.data['receiver']) {
      return StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Users data')
              .document(widget._document.data['sender'])
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('');
            return MaterialApp(
              home: Scaffold(
                body: SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 450,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(350),
                                    bottomLeft: Radius.circular(125),
                                  ),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        snapshot.data['imageProfile']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          snapshot.data['name'],
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${widget._document['topic']} (Topic)',
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Status: ${widget._document['eventStatus']}',
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(85, 85, 85, .7),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 30),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          child: Text(
                                            '${widget._document['details']} On ${widget._document.data['date'].toString().substring(0, 10)}' +
                                                ' start at ${widget._document.data['startTime']}, end at ${widget._document.data['endTime']}' +
                                                ' location ${widget._document.data['location']} with ${widget._document.data['moreInvite'].toString()}',
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  Color.fromRGBO(85, 85, 85, 1),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              // receiver incase Pending
                              if (widget._document.data['eventStatus'] ==
                                  'Pending')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Approved'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Wrapper()),
                                                );
                                              });
                                            },
                                            color:
                                                Color.fromRGBO(62, 230, 132, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Join',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Rejected'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Reject',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              // receiver incase Approved
                              else if (widget._document.data['eventStatus'] ==
                                  'Approved')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 45.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Completed'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color:
                                                Color.fromRGBO(62, 230, 192, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Complete',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Cancelled'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Cancel',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // receiver incase cancelled
                              if (widget._document.data['eventStatus'] ==
                                  'Cancelled')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Cancelled',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (widget._document.data['eventStatus'] ==
                                  'Rejected')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Rejected',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (widget._document.data['eventStatus'] ==
                                  'Completed')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Completed',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
    //Incase user is sender
    else if (widget._document.data['sender'] == widget._uid) {
      return StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Users data')
              .document(widget._document.data['receiver'])
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('');
            return MaterialApp(
              home: Scaffold(
                body: SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 450,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(350),
                                    bottomLeft: Radius.circular(125),
                                  ),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        snapshot.data['imageProfile']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          snapshot.data['name'],
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${widget._document['topic']} (Topic)',
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Status: ${widget._document['eventStatus']}',
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(85, 85, 85, .7),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 80),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          child: Text(
                                            '${widget._document['details']} On ${widget._document.data['date'].toString().substring(0, 10)}' +
                                                ' start at ${widget._document.data['startTime']}, end at ${widget._document.data['endTime']}' +
                                                ' location ${widget._document.data['location']} with ${widget._document.data['moreInvite'].toString()}',
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  Color.fromRGBO(85, 85, 85, 1),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              // sender pending
                              if (widget._document.data['eventStatus'] ==
                                  'Pending')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Cancelled'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Cancel',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              //sender approved
                              if (widget._document.data['eventStatus'] ==
                                  'Approved')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Completed'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color:
                                                Color.fromRGBO(62, 230, 192, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Complete',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Cancelled'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Cancel',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              // sender cancelled
                              if (widget._document.data['eventStatus'] ==
                                  'Cancelled')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Cancelled',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              //sender rejected
                              if (widget._document.data['eventStatus'] ==
                                  'Rejected')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Rejected',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              //sender completed
                              if (widget._document.data['eventStatus'] ==
                                  'Completed')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Completed',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 50,
                          right: 20,
                          child: TopOverlayBar(
                            isShowBackButton: true,
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
            );
          });
    }
    // Incase user is more invitee
    else {
      return StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Users data')
              .document(widget._document.data['sender'])
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('');
            return MaterialApp(
              home: Scaffold(
                body: SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 450,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(350),
                                    bottomLeft: Radius.circular(125),
                                  ),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        snapshot.data['imageProfile']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          snapshot.data['name'],
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${widget._document['topic']} (Topic)',
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Status: ${widget._document['eventStatus']}',
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(85, 85, 85, .7),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 30),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          child: Text(
                                            '${widget._document['details']} On ${widget._document.data['date'].toString().substring(0, 10)}' +
                                                ' start at ${widget._document.data['startTime']}, end at ${widget._document.data['endTime']}' +
                                                ' location ${widget._document.data['location']} with ${widget._document.data['moreInvite'].toString()}',
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  Color.fromRGBO(85, 85, 85, 1),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              // receiver incase Pending
                              if (widget._document.data['eventStatus'] ==
                                  'Pending')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Approved'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Wrapper()),
                                                );
                                              });
                                            },
                                            color:
                                                Color.fromRGBO(62, 230, 132, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Join',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Rejected'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Reject',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              // receiver incase Approved
                              else if (widget._document.data['eventStatus'] ==
                                  'Approved')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 45.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Completed'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color:
                                                Color.fromRGBO(62, 230, 192, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Complete',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            onPressed: () {
                                              String docID =
                                                  widget._document.documentID;
                                              var status = {
                                                'eventStatus': 'Cancelled'
                                              };
                                              Firestore.instance
                                                  .collection('Events')
                                                  .document(docID)
                                                  .updateData(status)
                                                  .then((value) => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Wrapper()),
                                                        )
                                                      });
                                            },
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Cancel',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // receiver incase cancelled
                              if (widget._document.data['eventStatus'] ==
                                  'Cancelled')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Cancelled',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (widget._document.data['eventStatus'] ==
                                  'Rejected')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Rejected',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (widget._document.data['eventStatus'] ==
                                  'Completed')
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, bottom: 20),
                                        child: ButtonTheme(
                                          minWidth: 350,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Color.fromRGBO(
                                                250, 137, 123, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'Completed',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 50,
                          right: 20,
                          child: TopOverlayBar(
                            isShowBackButton: true,
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
            );
          });
    }
  }
}
