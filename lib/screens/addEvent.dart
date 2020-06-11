import 'package:flutter/material.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:schedule_app/components/WelcomeText.dart';
import 'package:schedule_app/model/User.dart';
import 'package:schedule_app/services/CloudDataService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/wrapper.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
  final DateTime date;
  final String uid;
  bool isSliderShow;
  AddEventScreen({this.date, this.uid, this.isSliderShow = false});
}

class _AddEventScreenState extends State<AddEventScreen> {
  final CloudDataService firestore = CloudDataService();
  final _addEventFormKey = GlobalKey<FormState>();
  String _inviteUser;
  String startTime = '';
  String endTime = '';
  String _topic;
  String _details;
  String _moreInvite;
  List<String> _moreInviteList;
  String _location;
  double _time = 0;
  String _convertedTime = '00:00';
  String _hour;
  String _min;
  String _timeField;
  bool isValidTime = false;
  String _error = '';
  String _eventStatus;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('Users data')
                  .document(widget.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('No data');
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Form(
                      key: _addEventFormKey,
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 100),
                                child: Image(
                                  image: AssetImage('assets/images/5264.png'),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  WelcomeText(
                                    25,
                                    FontWeight.w400,
                                    'Make an appointment',
                                    paddingSide: EdgeInsets.only(top: 20),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  WelcomeText(
                                    15,
                                    FontWeight.w300,
                                    'Let’s do some events.',
                                    paddingSide: EdgeInsets.only(bottom: 40),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(bottom: 20, left: 15),
                                    width: 50,
                                    child: Text(
                                      'At',
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    width: 300,
                                    child: Text(
                                      widget.date
                                          .toIso8601String()
                                          .substring(0, 10),
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              StreamBuilder<DocumentSnapshot>(
                                  stream: Firestore.instance
                                      .collection('Users data')
                                      .document(user.uid)
                                      .snapshots(),
                                  builder: (context, snapshotMe) {
                                    if (!snapshotMe.hasData)
                                      return Text('no data');
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 0),
                                          padding: EdgeInsets.only(
                                            bottom: 20,
                                            left: 0,
                                          ),
                                          width: 100,
                                          child: Text(
                                            'Request by',
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  Color.fromRGBO(85, 85, 85, 1),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          padding: EdgeInsets.only(
                                              bottom: 20, left: 0),
                                          width: 200,
                                          child: Text(
                                            _inviteUser =
                                                snapshotMe.data['name'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromRGBO(85, 85, 85, 1),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(bottom: 20, left: 15),
                                    width: 50,
                                    child: Text(
                                      'With',
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(bottom: 20, left: 10),
                                    width: 300,
                                    child: Text(
                                      _inviteUser = snapshot.data['name'],
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.isSliderShow = true;
                                        _timeField = 'startTime';
                                      });
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(62, 220, 192, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Icon(
                                                Icons.access_time,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),
                                            Text(
                                              'Start time: $startTime',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Mitr",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w200,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _error.isNotEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 35.0),
                                          child: Text(
                                            _error,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Mitr",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.isSliderShow = true;
                                        _timeField = 'endTime';
                                      });
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(250, 137, 123, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Icon(
                                                Icons.timer_off,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),
                                            Text(
                                              'End time: $endTime',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Mitr",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w200,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _error.isNotEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 35.0),
                                          child: Text(
                                            _error,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Mitr",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 55,
                                    width: 350,
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      validator: (value) => value.isNotEmpty
                                          ? null
                                          : 'Please enter your event\'s topic.',
                                      onChanged: (value) =>
                                          {setState(() => _topic = value)},
                                      obscureText: false,
                                      decoration: new InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.dvr,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                        labelText: 'Topic',
                                        labelStyle: new TextStyle(
                                            fontFamily: "Mitr",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.white),
                                        fillColor:
                                            Color.fromRGBO(208, 220, 155, 1),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        filled: true,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0),
                                          borderSide: new BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      style: new TextStyle(
                                          fontFamily: "Mitr",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 350,
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: new TextFormField(
                                      validator: (value) => value.isNotEmpty
                                          ? null
                                          : 'Please enter event\'s details.',
                                      onChanged: (value) =>
                                          {setState(() => _details = value)},
                                      obscureText: false,
                                      decoration: new InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.library_books,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                        labelText: 'Details',
                                        labelStyle: new TextStyle(
                                            fontFamily: "Mitr",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.white),
                                        fillColor:
                                            Color.fromRGBO(255, 211, 138, 1),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        filled: true,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0),
                                          borderSide: new BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: new TextStyle(
                                          fontFamily: "Mitr",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 55,
                                    width: 350,
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      validator: (value) => value.isNotEmpty
                                          ? null
                                          : 'Please enter location\'s name.',
                                      onChanged: (value) =>
                                          {setState(() => _location = value)},
                                      obscureText: false,
                                      decoration: new InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                        labelText: 'Location',
                                        labelStyle: new TextStyle(
                                            fontFamily: "Mitr",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.white),
                                        fillColor:
                                            Color.fromRGBO(134, 152, 227, 1),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        filled: true,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0),
                                          borderSide: new BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      style: new TextStyle(
                                          fontFamily: "Mitr",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 55,
                                    width: 350,
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      onChanged: (value) => {
                                        setState(() => _moreInvite = value),
                                        _moreInvite = _moreInvite.isNotEmpty
                                            ? _moreInvite.trim()
                                            : null,
                                        _moreInviteList =
                                            _moreInvite.split(','),
                                      },
                                      obscureText: false,
                                      decoration: new InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.people_outline,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                        labelText:
                                            'More invite people (Optional)',
                                        labelStyle: new TextStyle(
                                            fontFamily: "Mitr",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.white),
                                        fillColor:
                                            Color.fromRGBO(134, 220, 227, 1),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        filled: true,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0),
                                          borderSide: new BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      style: new TextStyle(
                                          fontFamily: "Mitr",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 50),
                                    child: ButtonTheme(
                                      minWidth: 350,
                                      height: 50,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          // check form valid
                                          if (_addEventFormKey.currentState
                                              .validate()) {
                                            setState(() {
                                              // check time is empty ?
                                              if (startTime.isNotEmpty &&
                                                  endTime.isNotEmpty) {
                                                _error = '';
                                                //convert input String date to Datetime
                                                DateTime inputDate = DateTime(
                                                    widget.date.year,
                                                    widget.date.month,
                                                    widget.date.day);

                                                //get now Datetime
                                                DateTime nowDate = DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month,
                                                    DateTime.now().day);

                                                //convert input  startTime String date to Datetime
                                                String startTimeFormat =
                                                    inputDate
                                                            .toIso8601String()
                                                            .substring(0, 10) +
                                                        ' ' +
                                                        startTime +
                                                        ':00';
                                                //convert input  endTime String date to Datetime
                                                String endTimeFormat = inputDate
                                                        .toIso8601String()
                                                        .substring(0, 10) +
                                                    ' ' +
                                                    endTime +
                                                    ':00';
                                                // check time is today ? true
                                                if (inputDate == nowDate) {
                                                  // check time range is valid ?
                                                  if (
                                                      // check time range by start and end time
                                                      !DateTime.parse(
                                                                  startTimeFormat)
                                                              .isAfter(DateTime
                                                                  .parse(
                                                                      endTimeFormat)) &&
                                                          // check start by now time
                                                          !DateTime.now().isAfter(
                                                              DateTime.parse(
                                                                  startTimeFormat))) {
                                                    isValidTime = true;
                                                  } else {
                                                    _error =
                                                        'Range of time is invalid.';
                                                    isValidTime = false;
                                                  }
                                                } else
                                                // check time is today ? false
                                                {
                                                  // check time range is valid ?
                                                  if (!DateTime.parse(
                                                          startTimeFormat)
                                                      .isAfter(DateTime.parse(
                                                          endTimeFormat))) {
                                                    isValidTime = true;
                                                  } else {
                                                    _error =
                                                        'Range of time is invalid.';
                                                    isValidTime = false;
                                                  }
                                                }
                                              }
                                              // check in case empty
                                              else {
                                                _error =
                                                    'Please enter start time and end time of event.';
                                                isValidTime = false;
                                              }
                                              print(isValidTime);
                                            });

                                            // check isValidtime status to access data to database
                                            if (isValidTime) {
                                              await firestore
                                                  .addEventData(
                                                    user.uid,
                                                    widget.uid,
                                                    widget.date
                                                        .toIso8601String(),
                                                    _topic,
                                                    _details,
                                                    _inviteUser,
                                                    startTime,
                                                    endTime,
                                                    _location,
                                                    _eventStatus = 'Pending',
                                                    moreInvite: _moreInviteList,
                                                  )
                                                  //after finished access go to home
                                                  .then(
                                                      (value) => Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new Wrapper(),
                                                            ),
                                                          ));
                                            }
                                          }
                                        },
                                        color: Color.fromRGBO(255, 211, 138, 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 24,
                                              height: 24,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/fastclock.png'),
                                              ),
                                            ),
                                            Text(
                                              'Make an appointment',
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
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: TopOverlayBar(
                        isShowBackButton: true,
                      ),
                    ),
                    // timepicker and toggle condition
                    widget.isSliderShow
                        ? Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 350,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(204, 171, 216, 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 320, top: 20),
                                    child: RaisedButton(
                                      elevation: 0,
                                      shape: CircleBorder(),
                                      color: Color.fromRGBO(250, 137, 123, 1),
                                      onPressed: () => {
                                        setState(() {
                                          widget.isSliderShow = false;
                                        })
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Select time',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Mitr',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'At: $_convertedTime',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Mitr',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    height: 30,
                                    margin: EdgeInsets.only(top: 30),
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        trackHeight: 10,
                                        activeTrackColor:
                                            Color.fromRGBO(250, 137, 123, 1),
                                        inactiveTrackColor:
                                            Color.fromRGBO(255, 221, 148, .8),
                                        thumbColor:
                                            Color.fromRGBO(252, 254, 255, 1),
                                        valueIndicatorColor:
                                            Color.fromRGBO(252, 254, 255, 1),
                                        valueIndicatorTextStyle: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(84, 84, 84, 1),
                                        ),
                                      ),
                                      child: Slider(
                                        min: 0,
                                        max: 72,
                                        divisions: 72,
                                        value: _time,
                                        label: 'at: $_convertedTime o\'clock',
                                        onChanged: (value) {
                                          setState(() {
                                            _time = value;
                                            _hour = ((_time * 20) / 60)
                                                .floor()
                                                .toStringAsFixed(0);
                                            _min = ((_time * 10) % 60)
                                                .toStringAsFixed(0);
                                            _hour = _hour.length == 1
                                                ? '0' + _hour
                                                : _hour;
                                            _min = _min.length == 1
                                                ? '0' + _min
                                                : _min;
                                            _convertedTime = _hour + ':' + _min;

                                            // check time field
                                            if (_timeField == 'startTime') {
                                              startTime = _convertedTime;
                                            }

                                            // check time field
                                            else if (_timeField == 'endTime') {
                                              endTime = _convertedTime;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Padding(padding: EdgeInsets.all(0))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
