import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/model/User.dart';
import 'package:provider/provider.dart';

class CardListTemplate extends StatelessWidget {
  final DocumentSnapshot _document;
  final String _user;
  CardListTemplate(this._document, this._user);
  @override
  Widget build(BuildContext context) {
    var colorStatus = {
      'Pending': Color.fromRGBO(255, 221, 148, .4),
      'Approved': Color.fromRGBO(62, 230, 192, .4),
      'Cancelled': Color.fromRGBO(250, 137, 123, .4),
      'Rejected': Color.fromRGBO(180, 175, 175, .4),
      'Completed': Color.fromRGBO(134, 152, 227, .4),
      'Be over': Color.fromRGBO(204, 171, 216, .4),
      'Questioning': Color.fromRGBO(255, 148, 230, .4),
    };

    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('Users data')
            .document(_user)
            .snapshots(),
        builder: (context, snapshot) {
          final user = Provider.of<User>(context);
          //check snapshot data
          if (!snapshot.hasData) return Text('');
          return StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('Users data')
                  .document(user.uid)
                  .snapshots(),
              builder: (context, snapshotMe) {
                if (!snapshotMe.hasData)
                  return Padding(padding: EdgeInsets.all(0));
                String myName = snapshotMe.data['name'];
                String myStatusOnList;
                Map<dynamic, dynamic> eventMemberList =
                    _document.data['eventMemberList'] as Map<dynamic, dynamic>;
                eventMemberList.forEach((key, value) {
                  if (key == myName) {
                    myStatusOnList = value;
                  }
                });
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: _document.data['userCount'] <= 2
                        ? colorStatus[_document.data['eventStatus']]
                        : colorStatus[myStatusOnList],
                    elevation: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      padding: EdgeInsets.all(5),
                      height: 175,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 10,
                              backgroundImage: NetworkImage(
                                snapshot.data['imageProfile'],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '${_document.data['topic']} (Topic)',
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(85, 85, 85, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Status: ${_document.data['userCount'] <= 2 ? _document.data['eventStatus'] : myStatusOnList}',
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(85, 85, 85, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '${_document.data['startTime']} - ${_document.data['endTime']}',
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(85, 85, 85, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '${snapshot.data['name']}',
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(85, 85, 85, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '${_document.data['details']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(85, 85, 85, 8),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Location: ${_document.data['location']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(85, 85, 85, 8),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  _document.data['moreInvite']
                                          .toString()
                                          .isNotEmpty
                                      ? Text(
                                          'with: ${_document.data['moreInvite']}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 8),
                                          ),
                                        )
                                      : Text(''),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
