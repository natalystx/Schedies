import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule_app/components/BottomMenuBar.dart';
import 'package:schedule_app/components/EventDetailsTemplate.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/model/User.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';

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
    final user = Provider.of<User>(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('Users data')
                    .document(widget._uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  // check snapshot data
                  if (snapshot.hasData) {
                    // check user is in event
                    if (widget._document.data['moreInvite']
                            .toString()
                            .contains(snapshot.data['name']) ||
                        widget._document.data['sender'] == user.uid ||
                        widget._document.data['receiver'] == user.uid) {
                      // user is sender
                      if (widget._document.data['sender'] == user.uid) {
                        return EventDetailsTemplate(widget._document,
                            widget._document.data['receiver']);
                      } else if (widget._document.data['receiver'] ==
                          user.uid) {
                        return EventDetailsTemplate(
                            widget._document, widget._document.data['sender']);
                      } else if (widget._document.data['moreInvite']
                          .toString()
                          .contains(snapshot.data['name'])) {
                        return EventDetailsTemplate(
                            widget._document, widget._document.data['sender']);
                      }
                    } else {
                      return Text('');
                    }
                  } else {
                    return Text('');
                  }
                },
              ),
              Positioned(
                  top: 20,
                  right: 20,
                  child: TopOverlayBar(
                    isShowBackButton: true,
                  )),
              Positioned(bottom: 0, child: BottomMenuBar())
            ],
          ),
        ),
      ),
    );
  }
}
