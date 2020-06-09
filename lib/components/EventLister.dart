import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/components/EventCardList.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/model/DateProvider.dart';

class EventLister extends StatefulWidget {
  String _uid;
  EventLister(this._uid);

  @override
  _EventListerState createState() => _EventListerState();
}

class _EventListerState extends State<EventLister> {
  @override
  Widget build(BuildContext context) {
    final DateProvider date = Provider.of<DateProvider>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 25),
          height: 400,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('Events')
                  .where('date', isEqualTo: date.date.toString())
                  .orderBy('onCreatedTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text(' ');
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => EventCardList(context,
                      snapshot.data.documents[index], widget._uid.toString()),
                );
              }),
        ),
      ],
    );
  }
}
