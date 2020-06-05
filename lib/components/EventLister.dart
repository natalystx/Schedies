import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/components/EventCardList.dart';
import 'package:schedule_app/model/User.dart';
import 'package:provider/provider.dart';

class EventLister extends StatefulWidget {
  @override
  _EventListerState createState() => _EventListerState();
}

class _EventListerState extends State<EventLister> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Events')
            .where('uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('No data');
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                EventCardList(context, snapshot.data.documents[index]),
          );
        });
  }
}
