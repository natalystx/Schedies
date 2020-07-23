import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:schedule_app/components/CalendarCarousel.dart';
import 'package:schedule_app/components/ListChartDetails.dart';
import 'package:schedule_app/components/ReportChart.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:schedule_app/model/DateProvider.dart';
import 'package:schedule_app/model/EventReporter.dart';
import 'package:schedule_app/model/User.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String _selectedShowView = 'day';
  bool userSelected = false;
  int lastIndex = 0;
  bool isSelectedAllUsers = true;
  List<Map<String, dynamic>> isSeletedList = [];
  Map<dynamic, dynamic> selectedUserDetails = {};
  List<charts.Series<EventReporter, String>> _seriesList = [];
  Map<String, dynamic> _eventCounter = {
    'Pending': 0,
    'Approved': 0,
    'Cancelled': 0,
    'Rejected': 0,
    'Completed': 0,
    'Be over': 0,
  };
  int allEventCounter = 0;
  Map<String, Color> colorStatus = {
    'Pending': Color.fromRGBO(255, 221, 148, 1),
    'Approved': Color.fromRGBO(62, 230, 192, 1),
    'Cancelled': Color.fromRGBO(250, 137, 123, 1),
    'Rejected': Color.fromRGBO(180, 175, 175, 1),
    'Completed': Color.fromRGBO(134, 152, 227, 1),
    'Be over': Color.fromRGBO(204, 171, 216, 1),
    'Questioning': Color.fromRGBO(255, 148, 230, 1),
  };
  String _myName;
  List<EventReporter> _eventReportList = [];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DateProvider dateProvider = Provider.of<DateProvider>(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    String next7Days = DateTime.parse(dateProvider.date)
        .add(Duration(days: 6))
        .toIso8601String();
    return  Scaffold(
        backgroundColor: Color.fromRGBO(255, 202, 148, 1),
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Positioned(
              right: MediaQuery.of(context).size.width - 85,
              top: 20,
              child: TopOverlayBar(
                isShowRightIcon: false,
                isShowBackButton: true,
              ),
            ),
            Positioned(
              top: 85,
              left: 35,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            AppLocalizations.of(context).translate('report'),
                            style: TextStyle(
                              fontFamily: 'Mitr',
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          color:
                              _selectedShowView == 'day' ? Colors.white : null,
                          onPressed: () {
                            setState(() {
                              _selectedShowView = 'day';
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('day'),
                            style: TextStyle(
                              fontFamily: 'Mitr',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: _selectedShowView == 'day'
                                  ? Color.fromRGBO(85, 85, 85, 1)
                                  : Colors.white,
                            ),
                          ),
                        ),
                        FlatButton(
                          color:
                              _selectedShowView == 'week' ? Colors.white : null,
                          onPressed: () {
                            setState(() {
                              _selectedShowView = 'week';
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('week'),
                            style: TextStyle(
                              fontFamily: 'Mitr',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: _selectedShowView == 'week'
                                  ? Color.fromRGBO(85, 85, 85, 1)
                                  : Colors.white,
                            ),
                          ),
                        ),
                        FlatButton(
                          color: _selectedShowView == 'month'
                              ? Colors.white
                              : null,
                          onPressed: () {
                            setState(() {
                              _selectedShowView = 'month';
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('month'),
                            style: TextStyle(
                              fontFamily: 'Mitr',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: _selectedShowView == 'month'
                                  ? Color.fromRGBO(85, 85, 85, 1)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CalendarCarousel(user.uid, isMe: true),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: FlatButton(
                        color: isSelectedAllUsers ? Colors.white : null,
                        onPressed: () => {
                          setState(() {
                            userSelected = false;
                            selectedUserDetails = {};
                            isSelectedAllUsers = true;
                            isSeletedList[lastIndex]['isSelected'] = false;
                          })
                        },
                        child: Text(
                          AppLocalizations.of(context).translate('all-users'),
                          style: TextStyle(
                            fontFamily: 'Mitr',
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(85, 85, 85, 1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 110,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('Users data')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Padding(
                                  padding: EdgeInsets.all(0),
                                );

                              snapshot.data.documents.forEach((doc) {
                                isSeletedList.add({'isSelected': false});

                                if (doc.documentID == user.uid) {
                                  _myName = doc.data['name'];
                                }
                              });
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    snapshot.data.documents[index].documentID !=
                                            user.uid
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isSeletedList[lastIndex]
                                                    ['isSelected'] = false;
                                                isSeletedList[index]
                                                    ['isSelected'] = true;
                                                isSelectedAllUsers = false;
                                                userSelected = true;
                                                selectedUserDetails = {
                                                  'uid': snapshot
                                                      .data
                                                      .documents[index]
                                                      .documentID,
                                                  'name': snapshot.data
                                                      .documents[index]['name']
                                                };
                                                lastIndex = index;
                                              });
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: isSeletedList[
                                                                      index]
                                                                  ['isSelected']
                                                              ? Color.fromRGBO(
                                                                  62,
                                                                  230,
                                                                  192,
                                                                  1)
                                                              : Color.fromRGBO(
                                                                  255,
                                                                  202,
                                                                  148,
                                                                  1),
                                                          width: 2)),
                                                  child: CircleAvatar(
                                                    radius: 32.5,
                                                    backgroundImage:
                                                        NetworkImage(snapshot
                                                                .data
                                                                .documents[index]
                                                            ['imageProfile']),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    snapshot.data
                                                            .documents[index]
                                                        ['name'],
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          85, 85, 85, .95),
                                                      fontFamily: 'Mitr',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Padding(padding: EdgeInsets.all(0)),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          _selectedShowView == 'day'
                              ? Row(
                                  children: <Widget>[
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: ListChartDetails()),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.75,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.8,
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: Firestore.instance
                                              .collection('Events')
                                              .where('date',
                                                  isEqualTo: dateProvider.date)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData)
                                              return Padding(
                                                  padding: EdgeInsets.all(0));

                                            snapshot.data.documents
                                                .forEach((doc) {
                                              if (!userSelected) {
                                                if (doc.data['receiver'] ==
                                                        user.uid ||
                                                    doc.data['sender'] ==
                                                        user.uid ||
                                                    doc.data['moreInvite']
                                                        .contains(_myName)) {
                                                  doc.data
                                                      .forEach((key, value) {
                                                    if (key == 'eventStatus') {
                                                      _eventCounter[doc.data[
                                                          'eventStatus']] += 1;
                                                      allEventCounter += 1;
                                                    }
                                                  });
                                                }
                                              } else {
                                                if ((doc.data['receiver'] ==
                                                            user.uid ||
                                                        doc.data['sender'] ==
                                                            user.uid ||
                                                        doc.data['moreInvite']
                                                            .contains(
                                                                _myName)) &&
                                                    (doc.data['receiver'] ==
                                                            selectedUserDetails[
                                                                'uid'] ||
                                                        doc.data['moreInvite']
                                                            .toString()
                                                            .contains(
                                                                selectedUserDetails[
                                                                    'name']))) {
                                                  doc.data
                                                      .forEach((key, value) {
                                                    if (key == 'eventStatus') {
                                                      _eventCounter[doc.data[
                                                          'eventStatus']] += 1;
                                                      allEventCounter += 1;
                                                    }
                                                  });
                                                }
                                              }
                                            });
                                            _seriesList = [];
                                            print(_eventCounter);
                                            _eventCounter.forEach((key, value) {
                                              _eventReportList.add(
                                                  new EventReporter(value, key,
                                                      colorStatus[key]));
                                            });
                                            _eventReportList.toList();

                                            _seriesList.add(charts.Series(
                                                id: 'Events',
                                                data: _eventReportList,
                                                domainFn:
                                                    (EventReporter event, _) =>
                                                        event.eventStatus,
                                                measureFn:
                                                    (EventReporter event, _) =>
                                                        event.eventCounter,
                                                colorFn: (EventReporter event,
                                                        _) =>
                                                    charts.ColorUtil
                                                        .fromDartColor(
                                                            event.colorStatus),
                                                labelAccessorFn:
                                                    (EventReporter row, _) =>
                                                        '${row.eventCounter}'));

                                            _eventReportList = [];
                                            _eventCounter = {
                                              'Pending': 0,
                                              'Approved': 0,
                                              'Cancelled': 0,
                                              'Rejected': 0,
                                              'Completed': 0,
                                              'Be over': 0,
                                            };
                                            return ReportChart(_seriesList);
                                          }),
                                    ),
                                  ],
                                )
                              : Padding(padding: EdgeInsets.all(0)),
                          _selectedShowView == 'week'
                              ? Row(
                                  children: <Widget>[
                                    ListChartDetails(),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.75,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.8,
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: Firestore.instance
                                              .collection('Events')
                                              .where('date',
                                                  isGreaterThanOrEqualTo:
                                                      dateProvider.date
                                                          .substring(0, 9))
                                              .where('date',
                                                  isLessThanOrEqualTo:
                                                      next7Days.substring(0, 9))
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData &&
                                                snapshot.toString().isEmpty)
                                              return Padding(
                                                  padding: EdgeInsets.all(0));

                                            snapshot.data.documents
                                                .forEach((doc) {
                                              if (!userSelected) {
                                                if ((doc.data['receiver'] ==
                                                            user.uid ||
                                                        doc.data['sender'] ==
                                                            user.uid ||
                                                        doc.data['moreInvite']
                                                            .contains(
                                                                _myName)) &&
                                                    doc.data['date']
                                                        .toString()
                                                        .contains(dateProvider
                                                            .date
                                                            .substring(0, 6))) {
                                                  doc.data
                                                      .forEach((key, value) {
                                                    if (key == 'eventStatus') {
                                                      _eventCounter[doc.data[
                                                          'eventStatus']] += 1;
                                                      allEventCounter += 1;
                                                    }
                                                  });
                                                }
                                              } else {
                                                if ((doc.data['receiver'] ==
                                                            user.uid ||
                                                        doc.data['sender'] ==
                                                            user.uid ||
                                                        doc.data['moreInvite']
                                                            .contains(
                                                                _myName)) &&
                                                    (doc.data['date']
                                                            .toString()
                                                            .contains(
                                                                dateProvider
                                                                    .date
                                                                    .substring(
                                                                        0, 6)) &&
                                                        (doc.data['receiver'] ==
                                                                selectedUserDetails[
                                                                    'uid'] ||
                                                            doc.data['moreInvite']
                                                                .toString()
                                                                .contains(selectedUserDetails['name'])))) {
                                                  doc.data
                                                      .forEach((key, value) {
                                                    if (key == 'eventStatus') {
                                                      _eventCounter[doc.data[
                                                          'eventStatus']] += 1;
                                                      allEventCounter += 1;
                                                    }
                                                  });
                                                }
                                              }
                                            });
                                            _seriesList = [];
                                            print(_eventCounter);
                                            _eventCounter.forEach((key, value) {
                                              _eventReportList.add(
                                                  new EventReporter(value, key,
                                                      colorStatus[key]));
                                            });
                                            _eventReportList.toList();

                                            _seriesList.add(charts.Series(
                                                id: 'Events',
                                                data: _eventReportList,
                                                domainFn:
                                                    (EventReporter event, _) =>
                                                        event.eventStatus,
                                                measureFn:
                                                    (EventReporter event, _) =>
                                                        event.eventCounter,
                                                colorFn: (EventReporter event,
                                                        _) =>
                                                    charts.ColorUtil
                                                        .fromDartColor(
                                                            event.colorStatus),
                                                labelAccessorFn:
                                                    (EventReporter row, _) =>
                                                        '${row.eventCounter}'));

                                            _eventReportList = [];
                                            _eventCounter = {
                                              'Pending': 0,
                                              'Approved': 0,
                                              'Cancelled': 0,
                                              'Rejected': 0,
                                              'Completed': 0,
                                              'Be over': 0,
                                            };
                                            return ReportChart(_seriesList);
                                          }),
                                    ),
                                  ],
                                )
                              : Padding(padding: EdgeInsets.all(0)),
                          _selectedShowView == 'month'
                              ? Row(
                                  children: <Widget>[
                                    ListChartDetails(),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.75,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.8,
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: Firestore.instance
                                              .collection('Events')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData &&
                                                snapshot.toString().isEmpty)
                                              return Padding(
                                                  padding: EdgeInsets.all(0));

                                            snapshot.data.documents
                                                .forEach((doc) {
                                              if (!userSelected) {
                                                if ((doc.data['receiver'] ==
                                                            user.uid ||
                                                        doc.data['sender'] ==
                                                            user.uid ||
                                                        doc.data['moreInvite']
                                                            .contains(
                                                                _myName)) &&
                                                    doc.data['date']
                                                        .toString()
                                                        .contains(dateProvider
                                                            .date
                                                            .substring(0, 6))) {
                                                  doc.data
                                                      .forEach((key, value) {
                                                    if (key == 'eventStatus') {
                                                      _eventCounter[doc.data[
                                                          'eventStatus']] += 1;
                                                      allEventCounter += 1;
                                                    }
                                                  });
                                                }
                                              } else {
                                                if ((doc.data['receiver'] ==
                                                            user.uid ||
                                                        doc.data['sender'] ==
                                                            user.uid ||
                                                        doc.data['moreInvite']
                                                            .contains(
                                                                _myName)) &&
                                                    (doc.data['date']
                                                        .toString()
                                                        .contains(dateProvider
                                                            .date
                                                            .substring(
                                                                0, 6))) &&
                                                    (doc.data['receiver'] ==
                                                            selectedUserDetails[
                                                                'uid'] ||
                                                        doc.data['moreInvite']
                                                            .toString()
                                                            .contains(
                                                                selectedUserDetails['name']))) {
                                                  doc.data
                                                      .forEach((key, value) {
                                                    if (key == 'eventStatus') {
                                                      _eventCounter[doc.data[
                                                          'eventStatus']] += 1;
                                                      allEventCounter += 1;
                                                    }
                                                  });
                                                }
                                              }
                                            });
                                            _seriesList = [];
                                            print(_eventCounter);
                                            _eventCounter.forEach((key, value) {
                                              _eventReportList.add(
                                                  new EventReporter(value, key,
                                                      colorStatus[key]));
                                            });
                                            _eventReportList.toList();

                                            _seriesList.add(charts.Series(
                                                id: 'Events',
                                                data: _eventReportList,
                                                domainFn:
                                                    (EventReporter event, _) =>
                                                        event.eventStatus,
                                                measureFn:
                                                    (EventReporter event, _) =>
                                                        event.eventCounter,
                                                colorFn: (EventReporter event,
                                                        _) =>
                                                    charts.ColorUtil
                                                        .fromDartColor(
                                                            event.colorStatus),
                                                labelAccessorFn:
                                                    (EventReporter row, _) =>
                                                        '${row.eventCounter}'));

                                            _eventReportList = [];
                                            _eventCounter = {
                                              'Pending': 0,
                                              'Approved': 0,
                                              'Cancelled': 0,
                                              'Rejected': 0,
                                              'Completed': 0,
                                              'Be over': 0,
                                            };
                                            return ReportChart(_seriesList);
                                          }),
                                    ),
                                  ],
                                )
                              : Padding(padding: EdgeInsets.all(0)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      
    );
  }
}
