import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/components/ReasonBox.dart';
import 'package:schedule_app/model/User.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/chatting.dart';
import 'package:schedule_app/screens/editEvent.dart';
import 'package:schedule_app/services/AppLocalizations.dart';


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
    'Questioning': Color.fromRGBO(255, 148, 230, .4),
  };
  bool isShowReasonBox = false;
  String nameTemp;
  String chatID;
  List<dynamic> moreInvite= [];
  @override
  Widget build(BuildContext context) {
     Future<bool> _onDeletePressed() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure to delete event?'),
              actions: <Widget>[
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text("NO"),
                ),
                SizedBox(height: 16),
                new GestureDetector(
                  onTap: () async => {
                     await Firestore.instance.collection('Events').document(widget._document.documentID).delete().then((value) => 
                     Navigator.pushNamed(context, '/wrapper')
                     )
                   
                  },
                  child: Text("YES"),
                ),
              ],
            ),
          ) ??
          false;
    }
    final user = Provider.of<User>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('Users data')
            .document(widget._uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Padding(padding: EdgeInsets.all(0),);
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
                        StreamBuilder<DocumentSnapshot>(
                            stream: Firestore.instance
                                .collection('Users data')
                                .document(user.uid)
                                .snapshots(),
                            builder: (context, snapshotMe) {
                              if (!snapshotMe.hasData)
                                return Padding(padding: EdgeInsets.all(0));
                              Map<dynamic, dynamic> eventMemberList =
                                  widget._document['eventMemberList']
                                      as Map<dynamic, dynamic>;
                              String myEventStatus;
                              eventMemberList.forEach((key, value) {
                                if (key == snapshotMe.data['name']) {
                                  myEventStatus = value;
                                }
                              });
                              return Padding(
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
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${widget._document['topic']} (${AppLocalizations.of(context).translate('topic')})',
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                          widget._document.data['eventStatus'] == 'Pending' ||  widget._document.data['eventStatus'] == 'Approved' ?
                                        Container(
                                          height: 30,
                                           width: 45,
                                          margin: EdgeInsets.only(right:0),
                                          child: FlatButton(onPressed: () => {
                                           if(widget._document.data['userCount']<= 2){
                                              if (widget._document.data['receiver'].hashCode <=
                                              widget._document.data['sender'].hashCode) {
                                                chatID =
                                                '${widget._document.data['receiver']}-${widget._document.data['sender']}'
                                              } else {
                                                chatID =
                                                '${widget._document.data['sender']}-${widget._document.data['receiver']}'
                                              } 
                                           } else{
                                                if (widget._document.data['receiver'].hashCode <=
                                                  widget._document.data['sender'].hashCode) {
                                                    chatID =
                                                    '${widget._document.data['receiver']}-${widget._document.data['sender']}'
                                                } else {
                                                    chatID =
                                                    '${widget._document.data['sender']}-${widget._document.data['receiver']}'
                                                  } ,
                                               moreInvite = widget._document.data['moreInvite'],                                             
                                               moreInvite.forEach((name) {
                                                 chatID += '-'+name;
                                                })
                                                                                 
                                           },   
                                            chatID += '-'+widget._document.documentID,                                      
                                           Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChattingScreen(
                                                                chatID: chatID,
                                                                isShowChat: true,
                                                                receiver:
                                                                    widget._document,
                                                                sender: snapshotMe.data,    
                                                              )),
                                                    ),
                                          }, child: Icon(Icons.chat_bubble_outline, size: 25, color: Colors.black,),),
                                        ) 
                                        : Padding(padding: EdgeInsets.all(0)),

                                         widget._document.data['eventStatus'] == 'Pending' ?
                                        Container(
                                          height: 30,
                                          width: 45,
                                          child: FlatButton(onPressed: () => {
                                           Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                             EditEventScreen(
                                                               widget._document,
                                                               date: DateTime.parse(widget._document.data['date']),
                                                               uid: widget._uid,
                                                             )),
                                                    ),
                                                    
                                          }, child: Icon(Icons.edit, size: 25, color: Colors.black,),),
                                        ) :
                                         Padding(padding: EdgeInsets.all(0)),
                                         widget._document.data['eventStatus'] == 'Pending' ||  widget._document.data['eventStatus'] == 'Approved' ?
                                        Container(
                                          height: 30,
                                           width: 45,
                                          child: FlatButton(onPressed: () async =>  {
                                        await _onDeletePressed()
                                                    
                                          }, child: Icon(Icons.delete, size: 25, color: Colors.black,),),
                                        ) :
                                         Padding(padding: EdgeInsets.all(0)),
                                    ],),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${AppLocalizations.of(context).translate('status-2')} ${widget._document['userCount'] <= 2 ? widget._document['eventStatus'] : myEventStatus}',
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
                                    // is rejected or cancelled
                                    // check reason is not empty
                                    widget._document['reason'].toString().isNotEmpty
                                        ? Row(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width-40,
                                                child: Text(
                                                  '${AppLocalizations.of(context).translate('reason-2')} ${widget._document['reason']}',
                                                  maxLines: 5,
                                                  style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        85, 85, 85, .7),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : Text(''),
                                    widget._document['eventMemberList'].toString().isNotEmpty
                                        ? Row(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width -40,
                                                child: Text(
                                                  '${AppLocalizations.of(context).translate('member-status-2')} ${widget._document['eventMemberList']}',
                                                  maxLines: 10,
                                                  style: TextStyle(
                                                    fontFamily: 'Mitr',                                                  
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        85, 85, 85, .7),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : Text(''),    
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 30),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          child: Text(
                                            '${widget._document['details']}. ${AppLocalizations.of(context).translate('on')} ${widget._document.data['date'].toString().substring(0, 10)}' +
                                                ' ${AppLocalizations.of(context).translate('start-at')} ${widget._document.data['startTime']}, ${AppLocalizations.of(context).translate('end-at')} ${widget._document.data['endTime']}' +
                                                ' ${AppLocalizations.of(context).translate('location-2')} ${widget._document.data['location']} ' +
                                                '${widget._document.data['moreInvite'].toString().isNotEmpty ?  AppLocalizations.of(context).translate('with-2') + widget._document.data['moreInvite'].toString() : ''}. ',
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
                              );
                            }),

                        // button base on status

                        // pending and approved
                        (widget._document.data['eventStatus'] == 'Pending' ||
                                widget._document.data['eventStatus'] ==
                                    'Approved')
                            ? StreamBuilder<DocumentSnapshot>(
                                stream: Firestore.instance
                                    .collection('Users data')
                                    .document(user.uid)
                                    .snapshots(),
                                builder: (context, snapshotMe) {
                                  if (!snapshotMe.hasData)
                                    return Padding(padding: EdgeInsets.all(0));
                                  Map<dynamic, dynamic> eventMemberList =
                                      widget._document.data['eventMemberList']
                                          as Map<dynamic, dynamic>;
                                  String myEventStatus;
                                  eventMemberList.forEach((key, value) {
                                    if (key == snapshotMe.data['name']) {
                                      myEventStatus = value;
                                    }
                                  });
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(7.5),
                                              child: ButtonTheme(
                                                minWidth: 350,
                                                height: 50,
                                                child: myEventStatus == 'Pending'
                                                    ? RaisedButton(
                                                        elevation: 0,
                                                        onPressed: () => {
                                                          // set event status change

                                                          if (widget._document
                                                                          .data[
                                                                      'eventStatus'] ==
                                                                  'Pending' &&
                                                              widget._document
                                                                      .data[
                                                                  'userCount'] <= 2)
                                                            {                                                                                                                          
                                                                  Firestore
                                                                      .instance
                                                                      .document(
                                                                          'Events/${widget._document.documentID}')
                                                                      .updateData({
                                                                    'eventStatus':
                                                                        'Approved'
                                                                  }),
                                                                   Navigator.popAndPushNamed(
                                                                context,
                                                                '/wrapper'
                                                              )
                                                                
                                                            }
                                                          // check event member
                                                           else if (myEventStatus ==
                                                                  'Pending' && widget._document
                                                                          .data[
                                                                      'userCount'] >
                                                                  2)
                                                            {
                                                                  nameTemp =
                                                                      snapshotMe
                                                                              .data[
                                                                          'name'],
                                                                  Firestore
                                                                      .instance
                                                                      .document(
                                                                          'Events/${widget._document.documentID}')
                                                                      .updateData({
                                                                    'eventMemberList.$nameTemp':
                                                                        'Approved'
                                                                  }),
                                                                   Navigator.popAndPushNamed(
                                                                context,
                                                                '/wrapper'
                                                              )
                                                            }   
                                                          else if( (widget._document
                                                                      .data[
                                                                  'userCount'] <= 2 && widget._document
                                                                          .data[
                                                                      'eventStatus'] ==
                                                                  'Approved') || (widget._document
                                                                      .data[
                                                                  'userCount'] > 2 && (myEventStatus == 'Approved' && widget._document
                                                                          .data[
                                                                      'eventStatus'] ==
                                                                  'Approved')))
                                                            {
                                                              Firestore.instance
                                                                  .document(
                                                                      'Events/${widget._document.documentID}')
                                                                  .updateData({
                                                                'eventStatus':
                                                                    'Completed'
                                                              }),
                                                              Navigator.popAndPushNamed(
                                                                context,
                                                                '/wrapper'
                                                              )
                                                            }
                                                        },
                                                        color: widget._document.data['userCount'] <= 2 ? colorStatus[
                                                            widget._document
                                                                    .data[
                                                                'eventStatus']] : 
                                                                colorStatus[myEventStatus],
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                           widget._document.data['userCount'] <= 2 ? Text(
                                                              // display button text bosed on status
                                                              widget._document.data[
                                                                          'eventStatus'] ==
                                                                      'Pending'
                                                                  ? AppLocalizations.of(context).translate('accept')
                                                                  : AppLocalizations.of(context).translate('complete'),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                                            ) : Text(
                                                              // display button text bosed on status
                                                              myEventStatus ==
                                                                      'Pending'
                                                                  ? AppLocalizations.of(context).translate('accept')
                                                                  : AppLocalizations.of(context).translate('complete'),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                              padding:
                                                  const EdgeInsets.all(7.5),
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
                                                  color:
                                                      colorStatus['Cancelled'],
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(context).translate('cancel'),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontFamily: 'Mitr',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1)),
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
                                  );
                                })
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
