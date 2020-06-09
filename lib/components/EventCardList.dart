import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/screens/eventDetails.dart';

class EventCardList extends StatelessWidget {
  final BuildContext _context;
  final DocumentSnapshot _document;
  final String _uid;

  EventCardList(this._context, this._document, this._uid);
  var colorStatus = {
    'Pending': Color.fromRGBO(255, 221, 148, .4),
    'Approved': Color.fromRGBO(62, 230, 192, .4),
    'Cancelled': Color.fromRGBO(250, 137, 123, .4),
    'Rejected': Color.fromRGBO(180, 175, 175, .4),
    'Completed': Color.fromRGBO(134, 152, 227, .4),
  };
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetailsScreen(_document, _uid)),
        );
      },
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Users data')
              .document(_uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && _uid == _document.data['receiver']) {
              // Incase user is a reciever
              return ListTile(
                title: Card(
                  color: colorStatus[_document.data['eventStatus']],
                  elevation: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.all(5),
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _uid != _document.data['sender']
                                ? StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('Users data')
                                        .document(_document.data['sender'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) return Text('');
                                      return CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundImage: NetworkImage(
                                            snapshot.data['imageProfile']),
                                      );
                                    })
                                : StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('Users data')
                                        .document(_document.data['receiver'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) return Text('');
                                      return CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundImage: NetworkImage(
                                            snapshot.data['imageProfile']),
                                      );
                                    }),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Topic: ' +
                                        _document.data['topic'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(126, 119, 119, 1),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: StreamBuilder<DocumentSnapshot>(
                                          stream: Firestore.instance
                                              .collection('Users data')
                                              .document(_uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData)
                                              return Text(' ');
                                            return snapshot.data['name'] !=
                                                    _document.data['inviteUser']
                                                ? Text(
                                                    _document.data['inviteUser']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          126, 119, 119, 1),
                                                    ),
                                                  )
                                                : StreamBuilder<
                                                        DocumentSnapshot>(
                                                    stream: Firestore.instance
                                                        .collection(
                                                            'Users data')
                                                        .document(_document
                                                            .data['receiver'])
                                                        .snapshots(),
                                                    builder: (context,
                                                        snapshotReceiver) {
                                                      if (!snapshotReceiver
                                                          .hasData)
                                                        return Text(' ');
                                                      return Text(
                                                        snapshotReceiver
                                                            .data['name']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Mitr',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromRGBO(
                                                              126, 119, 119, 1),
                                                        ),
                                                      );
                                                    });
                                          }),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        _document.data['startTime'].toString() +
                                            '-' +
                                            _document.data['endTime']
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(126, 119, 119, 1),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          _document.data['details'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Location: ' +
                                              _document.data['location']
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'With ' +
                                              _document.data['moreInvite']
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            //Incase user is a sender
            else if (snapshot.hasData && _uid == _document.data['sender']) {
              return ListTile(
                title: Card(
                  color: colorStatus[_document.data['eventStatus']],
                  elevation: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.all(5),
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _uid == _document.data['sender']
                                ? StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('Users data')
                                        .document(_document.data['receiver'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) return Text('');
                                      return CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundImage: NetworkImage(
                                            snapshot.data['imageProfile']),
                                      );
                                    })
                                : StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('Users data')
                                        .document(_document.data['sender'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) return Text('');
                                      return CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundImage: NetworkImage(
                                            snapshot.data['imageProfile']),
                                      );
                                    }),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Topic: ' +
                                        _document.data['topic'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(126, 119, 119, 1),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: StreamBuilder<DocumentSnapshot>(
                                          stream: Firestore.instance
                                              .collection('Users data')
                                              .document(_uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData)
                                              return Text(' ');
                                            return snapshot.data['name'] !=
                                                    _document.data['inviteUser']
                                                ? Text(
                                                    _document.data['inviteUser']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          126, 119, 119, 1),
                                                    ),
                                                  )
                                                : StreamBuilder<
                                                        DocumentSnapshot>(
                                                    stream: Firestore.instance
                                                        .collection(
                                                            'Users data')
                                                        .document(_document
                                                            .data['receiver'])
                                                        .snapshots(),
                                                    builder: (context,
                                                        snapshotReceiver) {
                                                      if (!snapshotReceiver
                                                          .hasData)
                                                        return Text(' ');
                                                      return Text(
                                                        snapshotReceiver
                                                            .data['name']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Mitr',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromRGBO(
                                                              126, 119, 119, 1),
                                                        ),
                                                      );
                                                    });
                                          }),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        _document.data['startTime'].toString() +
                                            '-' +
                                            _document.data['endTime']
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(126, 119, 119, 1),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          _document.data['details'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Location: ' +
                                              _document.data['location']
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'With ' +
                                              _document.data['moreInvite']
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            //Incase user is a more invitee
            else if (snapshot.hasData &&
                _document.data['moreInvite']
                    .toString()
                    .contains(snapshot.data['name'])) {
              return ListTile(
                title: Card(
                  color: colorStatus[_document.data['eventStatus']],
                  elevation: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.all(5),
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _uid == _document.data['sender']
                                ? StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('Users data')
                                        .document(_document.data['receiver'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) return Text('');
                                      return CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundImage: NetworkImage(
                                            snapshot.data['imageProfile']),
                                      );
                                    })
                                : StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('Users data')
                                        .document(_document.data['sender'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) return Text('');
                                      return CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundImage: NetworkImage(
                                            snapshot.data['imageProfile']),
                                      );
                                    }),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Topic: ' +
                                        _document.data['topic'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(126, 119, 119, 1),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: StreamBuilder<DocumentSnapshot>(
                                          stream: Firestore.instance
                                              .collection('Users data')
                                              .document(_uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData)
                                              return Text(' ');
                                            return snapshot.data['name'] !=
                                                    _document.data['inviteUser']
                                                ? Text(
                                                    _document.data['inviteUser']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          126, 119, 119, 1),
                                                    ),
                                                  )
                                                : StreamBuilder<
                                                        DocumentSnapshot>(
                                                    stream: Firestore.instance
                                                        .collection(
                                                            'Users data')
                                                        .document(_document
                                                            .data['receiver'])
                                                        .snapshots(),
                                                    builder: (context,
                                                        snapshotReceiver) {
                                                      if (!snapshotReceiver
                                                          .hasData)
                                                        return Text(' ');
                                                      return Text(
                                                        snapshotReceiver
                                                            .data['name']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Mitr',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color.fromRGBO(
                                                              126, 119, 119, 1),
                                                        ),
                                                      );
                                                    });
                                          }),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        _document.data['startTime'].toString() +
                                            '-' +
                                            _document.data['endTime']
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(126, 119, 119, 1),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          _document.data['details'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Location: ' +
                                              _document.data['location']
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'With ' +
                                              _document.data['moreInvite']
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                126, 119, 119, 1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text('');
            }
          }),
    );
  }
}
