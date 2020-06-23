import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/components/EventCardList.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/model/DateProvider.dart';
import 'package:schedule_app/model/User.dart';

class EventLister extends StatefulWidget {
  String _uid;
  EventLister(this._uid);

  @override
  _EventListerState createState() => _EventListerState();
}

class _EventListerState extends State<EventLister> {
  List<String> temp = [];
  bool isAllStatusSame = false;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    final DateProvider date = Provider.of<DateProvider>(context);
    final user = Provider.of<User>(context);
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
                  .orderBy('eventStatus', descending: true)
                  .orderBy('onCreatedTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Text(' ');
                else {
                  snapshot.data.documents.forEach((doc) {
                    String endTimeFormat = doc.data['date'].substring(0, 10) +
                        ' ' +
                        doc.data['endTime'] +
                        ':00';
                    DateTime endTime = DateTime.parse(endTimeFormat);
                    if (doc.data['userCount'] > 2) {
                      Map<dynamic, dynamic> eventMemberList =
                          doc.data['eventMemberList'] as Map<dynamic, dynamic>;

                      eventMemberList.forEach((key, value) {
                        temp.add(value);
                        if (temp[0] == temp[counter]) {
                          isAllStatusSame = true;
                        } else {
                          isAllStatusSame = false;
                        }
                        counter++;
                      });
                      counter = 0;
                      if (isAllStatusSame) {
                        Firestore.instance
                            .collection('Events')
                            .document(doc.documentID)
                            .updateData({'eventStatus': temp[0]});
                      }
                      if (!isAllStatusSame) {
                        Firestore.instance
                            .collection('Events')
                            .document(doc.documentID)
                            .updateData({'isQuestioning': 'Yes'});
                      }
                    }
                    if (endTime.isBefore(DateTime.now()) &&
                        doc.data['eventStatus'] != 'Completed') {
                      Firestore.instance
                          .collection('Events')
                          .document(doc.documentID)
                          .updateData({'eventStatus': 'Be over'});
                    }
                  });
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => EventCardList(context,
                        snapshot.data.documents[index], widget._uid.toString()),
                  );
                }
              }),
        ),
      ],
    );
  }
}
