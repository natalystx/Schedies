import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/components/ReasonBox.dart';

import '../wrapper.dart';

class EventDetailsTemplate extends StatefulWidget {
  final String _uid;
  final DocumentSnapshot _document;
  EventDetailsTemplate(
    this._document,
    this._uid,
  );

  @override
  _EventDetailsTemplateState createState() => _EventDetailsTemplateState();
}

class _EventDetailsTemplateState extends State<EventDetailsTemplate> {
  var colorStatus = {
    'Pending': Color.fromRGBO(255, 221, 148, 1),
    'Approved': Color.fromRGBO(62, 230, 192, 1),
    'Cancelled': Color.fromRGBO(250, 137, 123, 1),
    'Rejected': Color.fromRGBO(180, 175, 175, 1),
    'Completed': Color.fromRGBO(134, 152, 227, 1),
    'Be over': Color.fromRGBO(204, 171, 216, .4),
  };
  bool isShowReasonBox = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('Users data')
            .document(widget._uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('');
          return SafeArea(
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
                              image:
                                  NetworkImage(snapshot.data['imageProfile']),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 85),
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
                                      color: Color.fromRGBO(85, 85, 85, 1),
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
                                      color: Color.fromRGBO(85, 85, 85, 1),
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
                                      color: Color.fromRGBO(85, 85, 85, .7),
                                    ),
                                  )
                                ],
                              ),
                              // is rejected or cancelled
                              // check reason is not empty
                              (widget._document['eventStatus'] == 'Rejected' ||
                                          widget._document['eventStatus'] ==
                                              'Cancelled') &&
                                      widget._document['reason'] != null
                                  ? Row(
                                      children: <Widget>[
                                        Text(
                                          'Reason: ${widget._document['reason']}',
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(85, 85, 85, .7),
                                          ),
                                        )
                                      ],
                                    )
                                  : Text(''),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 30),
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    child: Text(
                                      '${widget._document['details']}. On ${widget._document.data['date'].toString().substring(0, 10)}' +
                                          ' start at ${widget._document.data['startTime']}, end at ${widget._document.data['endTime']}' +
                                          ' location ${widget._document.data['location']} ' +
                                          '${widget._document.data['moreInvite'].toString().isNotEmpty ? "with " + widget._document.data['moreInvite'].toString() : ''}. ',
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),

                        // button base on status

                        // pending and approved
                        (widget._document.data['eventStatus'] == 'Pending' ||
                                widget._document.data['eventStatus'] ==
                                    'Approved')
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(7.5),
                                          child: ButtonTheme(
                                            minWidth: 350,
                                            height: 50,
                                            child: widget._document
                                                            .data['sender'] ==
                                                        widget._uid ||
                                                    widget._document.data[
                                                            'eventStatus'] ==
                                                        'Approved'
                                                ? RaisedButton(
                                                    elevation: 0,
                                                    onPressed: () => {
                                                      // set event status change

                                                      if (widget._document.data[
                                                              'eventStatus'] ==
                                                          'Pending')
                                                        {
                                                          Firestore.instance
                                                              .document(
                                                                  'Events/${widget._document.documentID}')
                                                              .updateData({
                                                            'eventStatus':
                                                                'Approved'
                                                          }),
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new Wrapper(),
                                                            ),
                                                          )
                                                        }
                                                      else
                                                        {
                                                          Firestore.instance
                                                              .document(
                                                                  'Events/${widget._document.documentID}')
                                                              .updateData({
                                                            'eventStatus':
                                                                'Completed'
                                                          }),
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new Wrapper(),
                                                            ),
                                                          )
                                                        }
                                                    },
                                                    color: colorStatus[widget
                                                        ._document
                                                        .data['eventStatus']],
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          // display button text bosed on status
                                                          widget._document.data[
                                                                      'eventStatus'] ==
                                                                  'Pending'
                                                              ? 'Accept'
                                                              : 'Complete',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1)),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Text(''),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(7.5),
                                          child: ButtonTheme(
                                            minWidth: 350,
                                            height: 50,
                                            child: RaisedButton(
                                              elevation: 0,
                                              onPressed: () => {
                                                setState(() {
                                                  isShowReasonBox = true;
                                                })
                                              },
                                              color: colorStatus['Cancelled'],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                                            FontWeight.w400,
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
                                  ],
                                ),
                              )
                            // not pending and approved
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 7.5,
                                        left: 7.5,
                                        right: 7.5,
                                        bottom: 30),
                                    child: ButtonTheme(
                                      minWidth: 350,
                                      height: 50,
                                      child: RaisedButton(
                                        elevation: 0,
                                        disabledColor: colorStatus[widget
                                            ._document.data['eventStatus']],
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              widget._document
                                                  .data['eventStatus'],
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: isShowReasonBox
                        ? GestureDetector(
                            onTap: (() {
                              setState(() {
                                isShowReasonBox = false;
                              });
                            }),
                            child: ReasonBox(widget._document))
                        : Text(''),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
