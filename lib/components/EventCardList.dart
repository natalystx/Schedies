import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/components/CardListTemplate.dart';
import 'package:schedule_app/model/User.dart';
import 'package:schedule_app/screens/eventDetails.dart';
import 'package:provider/provider.dart';

class EventCardList extends StatefulWidget {
  final BuildContext _context;
  final DocumentSnapshot _document;
  final String _uid;

  EventCardList(this._context, this._document, this._uid);

  @override
  _EventCardListState createState() => _EventCardListState();
}

class _EventCardListState extends State<EventCardList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EventDetailsScreen(widget._document, widget._uid)),
        );
      },
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Users data')
              .document(widget._uid)
              .snapshots(),
          builder: (context, snapshot) {
            //check snapshot data
            if (!snapshot.hasData) {
              return Text('NoData');
            }
            // check user is in event
            if (widget._uid == widget._document.data['sender'] ||
                widget._uid == widget._document.data['receiver'] ||
                widget._document.data['moreInvite']
                    .toString()
                    .contains(snapshot.data['name'])) {
              // user is sender
              if (user.uid == widget._document.data['sender']) {
                return CardListTemplate(
                    widget._document, widget._document.data['receiver']);
              }
              //user is receiver
              else if (user.uid == widget._document.data['receiver']) {
                return CardListTemplate(
                    widget._document, widget._document.data['sender']);
              }
              //user is more invitee
              else if (widget._document.data['moreInvite']
                  .toString()
                  .contains(snapshot.data['name'])) {
                return CardListTemplate(
                    widget._document, widget._document.data['sender']);
              }
            }
            return Text('');
          }),
    );
  }
}
